# No-Commander-Extend-Vote  
**Extend commander vote when nobody opted in and someone voted for him**  
  
***Project moving to:*** https://git.empiresmod.com/sourcemod/no_commander_extend_vote
**Latest version:** http://sourcemod.docs.empiresmod.com/no_commander_extend_vote/NoCommExtendVote.smx  
*Created by* **Neoony**  
  
**THIS IS IN VERY EARLY STATE**  
  
--  
  
**Commands:**  
  
**"nc_addvotetime"** *"def. 20"*  
*"How much to add to the current detected value of commander vote time, when extending vote time. (Seconds)"*  
  
**"nc_minplayers"** *"def. 2"*  
*"How many players needed to enable this plugin.(Clients on server..needs fixing to team players)"*  
  
**"nc_msgtimer"** *"def. 15"*  
*"How often to display the informational messages. (Seconds)"*  
  
**"nc_marktime"** *"def. 60"*  
*"At what time of the commander vote to extend the time. (Seconds)"*  
  
--  
  
If the commander vote time is below "nc_marktime" it will add extra time if no team has yet voted for a commander.  
It will keep extending the vote time by adding "nc_addvotetime" to the current detected vote time.  
  
--  
  
**Issues:**  
If somebody opts in for a commander and somebody votes for him, and then the commander opts out, it will still count as if the team has a commander.  
In other way, its set to "team has commander" if somebody in that team votes for a comm event.  
If you can think of another way, Iam all ears. But no event seems to exist for somebody just opting in or opting out or taking his vote back.  
  
--  
  
**Planned features**  
If the game starts without a commander elected, it will start a vote for next map and change the map.  
  
--  
  
**Changelog:**  
**v0.1**  
- First pre-release  
  
**v0.2**  
- Added new console commands  
- Added config  
- Better messages handling  
- Few bugfixes  
  
**v0.2.1 Quickfix**  
- Fixed infantry map spam  
- Added message about plugin on "OnClientPutInServer"  
- Few small message changes  
  
**v0.2.2 Quickadd**  
- Disabled "comm received vote" and added status of commanders into Timer Info message  
  
**v0.3**  
- New command  
- Few bugfixes  
- Player cant vote for themselves and be counted as comm ready  
- Some other things ( Gotta write down changes as I do them xD )  
- Plugin starts when at least one team has a player  
- Overall improved plugin handling  
  
**v0.4**  
- Many bugfixes  
- Quite a lot of polishing  
  
**v0.4l**  
- License changes  
  
