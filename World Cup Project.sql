--View Dataset
Select *
From worldcup


-- Number of World Cup played by Countries
Select Team,
Count (Team) as no_of_comp_played
From worldcup
Group by Team
Order by no_of_comp_played Desc


-- Total Number of World Cup Games Played
Select Team,
Sum ("Games Played") as Total_Matches_played
From worldcup
Group by Team
Order by Total_Matches_played Desc

-- Total Number of World Cup Games Won,Drew,Lost and Games Played 
Select Team,
Sum(Win)as Total_wins,
Sum(Draw)as Total_Draws,
Sum(Loss)as Total_Losses,
Sum ("Games Played") as Total_Matches_played
from worldcup
Group by Team
Order by Total_Matches_played Desc

-- Most World Cup Won By Countries
Select Team,
Count(Team) as WorldCupWon
From worldcup
Where Position= 1
Group by Team
Order by WorldCupWon Desc

-- Most Semi Final Qulification
Select Team,
Count(Team) as SemiFinalQul
From worldcup
Where Position<= 4
Group by Team
Order by SemiFinalQul Desc


-- Total Goal Scored in A World Cup
Select Year,Host,
Sum ("Goals Scored") as TotalGoals
From worldcup
Group by Year,Host
Order by TotalGoals Desc

-- Total Goals Scored and Conceded By A Team
Select Team,
Sum("Goals Scored") as TotalGoalScored,
Sum("Goals Conceded") as TotalGoalCon
From worldcup
Group by Team
Order by TotalGoalScored Desc


-- Average Goal per WorldCup Played

Select Team,
Count (Team) as no_of_comp_played,
Sum("Goals Scored") as TotalGoalScored,
Sum("Goals Conceded") as TotalGoalCon,
Round(Sum("Goals Scored")/Count (Team),2) as AvgGoalperCom
From worldcup
Group by Team
Order by AvgGoalperCom Desc