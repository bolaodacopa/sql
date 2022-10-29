DROP PROCEDURE ranking;
CREATE PROCEDURE ranking()
begin
	select
		TEMP.username
		,TEMP.name
		,TEMP.total
		,TEMP.correctmatches
		,rank() over (order by TEMP.total desc, TEMP.correctmatches desc) myrank
	from
	(
		select
			A.username
			,A.name
			, sum(case
		            	when B.hometeamgoals = M.hometeamgoals and B.awayteamgoals = M.awayteamgoals then 5
		            	when B.hometeamresult = M.hometeamresult and B.awayteamresult = M.awayteamresult then 3
		            	else 0
		      	end) as 'total'
			, sum(case
		            	when B.hometeamgoals = M.hometeamgoals and B.awayteamgoals = M.awayteamgoals then 1
		            	else 0
		      	end) as 'correctmatches'
		     
		from bets B
		left join matches M on (B.match_id = M.id)
		left join accounts A on (B.account_id = A.id) 
		group by A.username, A.name 
		order by total desc, correctmatches desc, A.username
	) TEMP
	order by myrank;
end;
