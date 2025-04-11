-- JOINS

# This query retrieves the school names, community names, average student attendance, and hardship index for communities with a hardship index of 98.
SELECT CPS.NAME_OF_SCHOOL, CPS.COMMUNITY_AREA_NAME, CPS.AVERAGE_STUDENT_ATTENDANCE, CSD.HARDSHIP_INDEX
FROM chicago_public_schools AS CPS INNER JOIN chicago_socioeconomic_data AS CSD 
ON CPS.COMMUNITY_AREA_NAME = CSD.COMMUNITY_AREA_NAME AND CSD.HARDSHIP_INDEX = 98;

# This query retrieves case numbers, primary crime types, community area names, and location descriptions for crimes that occurred at school locations.
SELECT CC.CASE_NUMBER, CC.PRIMARY_TYPE, CSD.COMMUNITY_AREA_NAME, CC.LOCATION_DESCRIPTION
FROM chicago_crime AS CC INNER JOIN chicago_socioeconomic_data AS CSD
ON CC.COMMUNITY_AREA_NUMBER = CSD.COMMUNITY_AREA_NUMBER AND CC.LOCATION_DESCRIPTION LIKE '%SCHOOL%';

-- VIEWS

# This query creates a view named CHICAGO_SCHOOL_RATINGS that shows ratings for various aspects of schools including safety, family involvement, environment, instruction, leadership, and teachers.
CREATE VIEW CHICAGO_SCHOOL_RATINGS AS SELECT NAME_OF_SCHOOL AS School_Name , Safety_Icon AS Safety_Rating, Family_Involvement_Icon AS Family_Rating, Environment_Icon AS Environment_Rating, Instruction_Icon AS Instruction_Rating, Leaders_Icon AS Leaders_Rating, Teachers_Icon AS Teachers_Rating
FROM chicago_public_schools;

-- STORED PROCEDURES

# This procedure updates the Leaders_Score field in the chicago_public_schools table for a given School_ID using the provided Leader_Score value.
DELIMITER //
CREATE PROCEDURE UPDATE_LEADERS_SCORE(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

BEGIN
UPDATE chicago_public_schools 
SET Leaders_Score = in_Leader_Score
WHERE School_ID = in_School_ID;
END //

DELIMITER ; 

# This stored procedure updates both the Leaders_Score and Leaders_Icon fields in the chicago_public_schools table based on the Leader_Score value provided.
DELIMITER //
CREATE PROCEDURE UPDATE_LEADERS_SCORE(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)

BEGIN
IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN 
	UPDATE chicago_public_schools
	SET Leaders_Score = in_Leader_Score, Leaders_Icon = 'Very weak'
	WHERE School_ID = in_School_ID;
ELSEIF in_Leader_Score > 20 AND in_Leader_Score < 40 THEN 
	UPDATE chicago_public_schools
	SET Leaders_Score = in_Leader_Score, Leaders_Icon = 'Weak'
	WHERE School_ID = in_School_ID;
ELSEIF in_Leader_Score > 40 AND in_Leader_Score < 60 THEN 
	UPDATE chicago_public_schools
	SET Leaders_Score = in_Leader_Score, Leaders_Icon = 'Average'
	WHERE School_ID = in_School_ID;
ELSEIF in_Leader_Score > 60 AND in_Leader_Score < 80 THEN 
	UPDATE chicago_public_schools
	SET Leaders_Score = in_Leader_Score, Leaders_Icon = 'Strong'
	WHERE School_ID = in_School_ID;
ELSEIF in_Leader_Score > 80 AND in_Leader_Score < 100 THEN 
	UPDATE chicago_public_schools
	SET Leaders_Score = in_Leader_Score, Leaders_Icon = 'Very Strong'
	WHERE School_ID = in_School_ID;
END IF;
END //

DELIMITER ; 
