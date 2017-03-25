# No-Commander-Extend-Vote
Extend commander vote when nobody opted in and someone voted for him </br>

Created by Neoony </br>

THIS IS IN VERY EARLY STATE </br>

Commands:
"nc_addvotetime" "def. 20" </br>
"How much to add to the current detected value of commander vote time, when extending vote time. (Seconds)" </br>

"nc_minplayers" "def. 2" </br>
"How many players needed to enable this plugin.(Clients on server..needs fixing to team players)" </br>

"nc_msgtimer" "def. 15" </br>
"How often to display the informational messages. (Seconds) </br>

"nc_marktime" "def. 60" </br>
"At what time of the commander vote to extend the time. (Seconds)" </br>

If the commander vote time is below "nc_marktime" it will add extra time if no team has yet voted for a commander. </br>
It will keep extending the vote time by adding "nc_addvotetime" to the current detected vote time, each time it gets below 60 seconds with no comms  </br>

Issues: </br>
If somebody opts in for a commander and somebody votes for him, and then the commander opts out, it will still count as if the team has a commander. </br>
In other way, its set to "team has commander" if somebody in that team votes for a comm event. </br>
If you can think of another way, Iam all ears. But no event seems to exist for somebody just opting in or opting out or taking his vote back </br>

Planned features </br>
If the game starts without a commander elected, it will start a vote for next map and change the map. </br>

Changelog: </br>
v0.1 </br>
-First pre-release </br>
v0.2 </br>
-Added new console commands </br>
-Added config </br>
-Better messages handling </br>
-Few bugfixes </br>
v0.2.1 Quickfix </br>
-Fixed infantry map spam </br>
-Added message about plugin on "OnClientPutInServer" </br>
-Few small message changes </br>
v0.2.2 Quickadd </br>
-Disabled "comm received vote" and added status of commanders into Timer Info message. </br>
v0.3 </br>
-New command </br>
-Few bugfixes </br>
-Player cant vote for themselves and be counted as comm ready. </br>
-Some other things ( Gotta write down changes as I do them xD ) </br>
-Plugin starts when at least one team has a player. </br>
