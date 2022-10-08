/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 1 of the case study, which means that there'll be more guidance for you about how to 
setup your local SQLite connection in PART 2 of the case study. 

The questions in the case study are exactly the same as with Tier 2. 

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */

Results:
localhost/admin_springboard/Facilities/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 -  4 (5 total, Query took 0.0009 seconds.)


SELECT name
FROM Facilities 
WHERE membercost > 0;


name	
Tennis Court 1	
Tennis Court 2	
Massage Room 1	
Massage Room 2	
Squash Court	



/* Q2: How many facilities do not charge a fee to members? */


localhost/admin_springboard/Facilities/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard
Your SQL query has been executed successfully.

SELECT COUNT(*)
FROM Facilities 
WHERE membercost = 0;



4	



/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

localhost/admin_springboard/Facilities/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 -  4 (5 total, Query took 0.0007 seconds.)


SELECT facid, name, membercost, monthlymaintenance
FROM Facilities
WHERE membercost > 0 AND membercost < monthlymaintenance * 0.2;


facid	name	membercost	monthlymaintenance	
0	Tennis Court 1	5.0	200	
1	Tennis Court 2	5.0	200	
4	Massage Room 1	9.9	3000	
5	Massage Room 2	9.9	3000	
6	Squash Court	3.5	80	



/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */

localhost/admin_springboard/Facilities/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 -  1 (2 total, Query took 0.0003 seconds.)


SELECT *
FROM Facilities
WHERE facid IN (1,5);


facid	name	membercost	guestcost	initialoutlay	monthlymaintenance	
1	Tennis Court 2	5.0	25.0	8000	200	
5	Massage Room 2	9.9	80.0	4000	3000	



/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */

localhost/admin_springboard/Facilities/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 -  8 (9 total, Query took 0.0009 seconds.)


SELECT name, monthlymaintenance,
	   CASE 
	   		WHEN monthlymaintenance > 100 THEN 'expensive'
	   		ELSE 'cheap'
	   END as maintenance_cost
FROM Facilities;


name	monthlymaintenance	maintenance_cost	
Tennis Court 1	200	expensive	
Tennis Court 2	200	expensive	
Badminton Court	50	cheap	
Table Tennis	10	cheap	
Massage Room 1	3000	expensive	
Massage Room 2	3000	expensive	
Squash Court	80	cheap	
Snooker Table	15	cheap	
Pool Table	15	cheap	




/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */

localhost/admin_springboard/Members/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 -  0 (1 total, Query took 0.0024 seconds.)


SELECT firstname, surname, joindate FROM Members
WHERE joindate= (SELECT MAX(joindate) FROM Members);



Darren	Smith	2012-09-26 18:08:45	



/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

localhost/admin_springboard/Members/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 - 24 (46 total, Query took 0.0812 seconds.)


SELECT DISTINCT CONCAT_WS(' ',firstname,surname) as member_name, name AS court_name
FROM Members AS m
INNER JOIN Bookings AS b ON m.memid = b.memid
INNER JOIN Facilities AS f ON b.facid = f.facid
WHERE name LIKE 'Tennis Court%'
ORDER BY member_name;


member_name   	court_name	
Anne Baker	Tennis Court 1	
Anne Baker	Tennis Court 2	
Burton Tracy	Tennis Court 1	
Burton Tracy	Tennis Court 2	
Charles Owen	Tennis Court 2	
Charles Owen	Tennis Court 1	
Darren Smith	Tennis Court 2	
David Farrell	Tennis Court 2	
David Farrell	Tennis Court 1	
David Jones	Tennis Court 1	
David Jones	Tennis Court 2	
David Pinker	Tennis Court 1	
Douglas Jones	Tennis Court 1	
Erica Crumpet	Tennis Court 1	
Florence Bader	Tennis Court 1	
Florence Bader	Tennis Court 2	
Gerald Butters	Tennis Court 1	
Gerald Butters	Tennis Court 2	
GUEST GUEST	Tennis Court 2	
GUEST GUEST	Tennis Court 1	
Henrietta Rumney	Tennis Court 2	
Jack Smith	Tennis Court 2	
Jack Smith	Tennis Court 1	
Janice Joplette	Tennis Court 2	
Janice Joplette	Tennis Court 1	




/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

localhost/admin_springboard/Facilities/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 - 11 (12 total, Query took 0.0002 seconds.)


SELECT F.name AS facility_name, CONCAT_WS(' ',M.firstname,M.surname) as member_name, CASE WHEN M.memid=0 THEN (F.guestcost* B.slots)
ELSE (F.membercost*B.slots) END AS cost
FROM Facilities F
JOIN Bookings B ON F.facid= B.facid
JOIN Members M ON B.memid= M.memid
WHERE B.starttime LIKE '%2012-09-14%'
HAVING cost>30
Order BY cost DESC;


facility_name	member_name	cost   	
Massage Room 2	GUEST GUEST	320.0	
Massage Room 1	GUEST GUEST	160.0	
Massage Room 1	GUEST GUEST	160.0	
Massage Room 1	GUEST GUEST	160.0	
Tennis Court 2	GUEST GUEST	150.0	
Tennis Court 1	GUEST GUEST	75.0	
Tennis Court 1	GUEST GUEST	75.0	
Tennis Court 2	GUEST GUEST	75.0	
Squash Court	GUEST GUEST	70.0	
Massage Room 1	Jemima Farrell	39.6	
Squash Court	GUEST GUEST	35.0	
Squash Court	GUEST GUEST	35.0	




/* Q9: This time, produce the same result as in Q8, but using a subquery. */

localhost/admin_springboard/F/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 - 11 (12 total, Query took 0.0167 seconds.)


SELECT F.name AS facility_name, CONCAT_WS(' ',M.firstname,M.surname) as member_name, CASE WHEN M.memid=0 THEN (F.guestcost* B.slots)
ELSE (F.membercost*B.slots) END AS cost
FROM (SELECT *FROM Bookings WHERE starttime BETWEEN '2012-09-14' AND '2012-09-15') B
JOIN Facilities F ON B.facid = F.facid
INNER JOIN Members M ON B.memid = M.memid
HAVING cost > 30
ORDER BY cost DESC;


facility_name	member_name	cost   	
Massage Room 2	GUEST GUEST	320.0	
Massage Room 1	GUEST GUEST	160.0	
Massage Room 1	GUEST GUEST	160.0	
Massage Room 1	GUEST GUEST	160.0	
Tennis Court 2	GUEST GUEST	150.0	
Tennis Court 1	GUEST GUEST	75.0	
Tennis Court 2	GUEST GUEST	75.0	
Tennis Court 1	GUEST GUEST	75.0	
Squash Court	GUEST GUEST	70.0	
Massage Room 1	Jemima Farrell	39.6	
Squash Court	GUEST GUEST	35.0	
Squash Court	GUEST GUEST	35.0	




PART 2: SQLite
/* We now want you to jump over to a local instance of the database on your machine. 

Copy and paste the LocalSQLConnection.py script into an empty Jupyter notebook, and run it. 

Make sure that the SQLFiles folder containing thes files is in your working directory, and
that you haven't changed the name of the .db file from 'sqlite\db\pythonsqlite'.

You should see the output from the initial query 'SELECT * FROM FACILITIES'.

Complete the remaining tasks in the Jupyter interface. If you struggle, feel free to go back
to the PHPMyAdmin interface as and when you need to. 

You'll need to paste your query into value of the 'query1' variable and run the code block again to get an output.*/
 
QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

localhost/admin_springboard/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 -  2 (3 total, Query took 0.2657 seconds.)


SELECT name as facility_name, total_revenue
                    FROM (SELECT name, SUM(CASE WHEN Bookings.memid = 0
                        THEN Facilities.guestcost * slots
                        ELSE Facilities.membercost * slots END) as total_revenue
                        FROM Bookings JOIN Members ON Bookings.memid = Members.memid
                        JOIN Facilities ON Bookings.facid = Facilities.facid
                        GROUP BY name) as facility_revenue
                    WHERE total_revenue < 1000
                    ORDER BY total_revenue DESC;


facility_name	total_revenue   	
Pool Table	270.0	
Snooker Table	240.0	
Table Tennis	180.0	


/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */

/* Here I use CONCAT but different syntax in the notebook */

localhost/admin_springboard/Members/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 - 21 (22 total, Query took 0.0026 seconds.)


SELECT m1.memid AS ID, CONCAT_WS(', ', m1.surname, m1.firstname) as member_name, 
                            CONCAT_WS(', ', m2.surname, m2.firstname) as recommender_name FROM Members as m1
                            INNER JOIN Members as m2 ON m1.recommendedby = m2.memid 
                            WHERE m1.firstname NOT LIKE 'GUEST' AND m2.firstname NOT LIKE 'GUEST'  
                            ORDER BY member_name;


ID	member_name   	recommender_name	
15	Bader, Florence	Stibbons, Ponder	
12	Baker, Anne	Stibbons, Ponder	
16	Baker, Timothy	Farrell, Jemima	
8	Boothe, Tim	Rownam, Tim	
5	Butters, Gerald	Smith, Darren	
22	Coplin, Joan	Baker, Timothy	
36	Crumpet, Erica	Smith, Tracy	
7	Dare, Nancy	Joplette, Janice	
20	Genting, Matthew	Butters, Gerald	
35	Hunt, John	Purview, Millicent	
11	Jones, David	Joplette, Janice	
26	Jones, Douglas	Jones, David	
4	Joplette, Janice	Smith, Darren	
21	Mackenzie, Anna	Smith, Darren	
10	Owen, Charles	Smith, Darren	
17	Pinker, David	Farrell, Jemima	
30	Purview, Millicent	Smith, Tracy	
27	Rumney, Henrietta	Genting, Matthew	
24	Sarwin, Ramnaresh	Bader, Florence	
14	Smith, Jack	Smith, Darren	
9	Stibbons, Ponder	Tracy, Burton	
29	Worthington-Smyth, Henry	Smith, Tracy	



/* Q12: Find the facilities with their usage by member, but not guests */

localhost/admin_springboard/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 - 24 (202 total, Query took 0.2062 seconds.)


SELECT f.name AS facility_name, b.memid as member_ID, COUNT(f.name) AS facility_usage_count
        FROM Bookings AS b INNER JOIN Facilities AS f ON b.facid = f.facid
        INNER JOIN Members AS m ON b.memid = m.memid
        GROUP BY f.name, m.memid
        HAVING m.memid <> 0;


facility_name	member_ID	facility_usage_count	
Badminton Court	1	132	
Badminton Court	2	32	
Badminton Court	3	4	
Badminton Court	5	20	
Badminton Court	6	2	
Badminton Court	7	10	
Badminton Court	8	12	
Badminton Court	9	16	
Badminton Court	10	6	
Badminton Court	11	8	
Badminton Court	12	10	
Badminton Court	13	7	
Badminton Court	14	12	
Badminton Court	15	9	
Badminton Court	16	7	
Badminton Court	17	7	
Badminton Court	21	30	
Badminton Court	24	7	
Badminton Court	26	2	
Badminton Court	29	4	
Badminton Court	30	2	
Badminton Court	33	1	
Badminton Court	35	2	
Badminton Court	36	2	
Massage Room 1	1	28	


/* Q13: Find the facilities usage by month, but not guests */

/* In this one I use MONTH to extract the month from the date, but as this won't work in Python, I used strftime there */

localhost/admin_springboard/f/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=admin_springboard

   Showing rows 0 - 24 (27 total, Query took 0.2133 seconds.)


SELECT f.name AS facility_name, MONTH(b.starttime) AS month, COUNT(f.name) AS facilities_usage_count
        FROM Bookings AS b
        INNER JOIN Facilities AS f
        USING (facid)
        INNER JOIN Members AS m
        USING (memid)
        WHERE memid <>0
        GROUP BY  f.name, MONTH(b.starttime);


facility_name	month	facilities_usage_count	
Badminton Court	7	51	
Badminton Court	8	132	
Badminton Court	9	161	
Massage Room 1	7	77	
Massage Room 1	8	153	
Massage Room 1	9	191	
Massage Room 2	7	4	
Massage Room 2	8	9	
Massage Room 2	9	14	
Pool Table	7	103	
Pool Table	8	272	
Pool Table	9	408	
Snooker Table	7	68	
Snooker Table	8	154	
Snooker Table	9	199	
Squash Court	7	23	
Squash Court	8	85	
Squash Court	9	87	
Table Tennis	7	48	
Table Tennis	8	143	
Table Tennis	9	194	
Tennis Court 1	7	65	
Tennis Court 1	8	111	
Tennis Court 1	9	132	
Tennis Court 2	7	41	


