# No-Commander-Extend-Vote
Extend commander vote when nobody opted in and someone voted for him </br>

Created by Neoony </br>

THIS IS IN VERY EARLY STATE </br>

Commands:
"nc_addvotetime" "20" "How much to add to the current detected value of commander vote time, when extending vote time." </br>
"nc_minplayers", "2", "How many players needed to enable this plugin.(players in a team)" </br>
"nc_msgtimer", "15", "How often to display the informational messages." </br>

If the commander vote time is below 60 it will add extra time if no team has yet voted for a commander. </br>
It will keep extending the vote time by approximately 20 seconds, each time it gets below 60 seconds with no comms  </br>

Issues: </br>
If somebody opts in for a commander and somebody votes for him, and then the commander opts out, it will still count as if the team has a commander. </br>
In other way, its set to "team has commander" if somebody in that team votes for a comm event. </br>
If you can think of another way, Iam all ears. But no event seems to exist for somebody just opting in or opting out or taking his vote back </br>

Planned features </br>
If the game starts without a commander elected, it will start a vote for next map and change the map. </br>

Changelog:
v0.1
-First pre-release
v0.2
-Added new console commands
-Added config
-Better messages handling
-Few bigfixes
