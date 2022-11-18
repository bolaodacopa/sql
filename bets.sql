select a.name as 'PARTICIPANTE' 
,m.matchgroup  as 'GRUPO'
,concat(th.name, ' ', b.hometeamgoals, ' X ', b.awayteamgoals, ' ', ta.name) as 'PALPITE' 
from matches m
left join teams th on (m.hometeam_id = th.id)
left join teams ta on (m.awayteam_id = ta.id)
left join bets b on (b.match_id = m.id) 
left join accounts a on (b.account_id = a.id)
left join stages s on (m.stage_id = s.id)
where s.name = 'GRUPOS'
order by a.name, m.matchgroup
