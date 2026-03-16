USE INF2025i_AppleMusicLight;

-- 1. Alle Benutzer anzeigen
SELECT * FROM user;

-- 2. Alle Benutzer Die Premium haben
SELECT Benutzername, Emailadresse
FROM user
WHERE HatPremium = 1;

-- 3. Alle Tracks, die länger als 3 Minuten (180 Sekunden) sind
SELECT Titel, Dauer_Sekunden
FROM track
WHERE Dauer_Sekunden > 180
ORDER BY Dauer_Sekunden DESC;

-- 4. Alle Alben eines bestimmten Genres
SELECT Titel, Erscheinungsdatum, Genre
FROM album
WHERE Genre = 'Alternative'
ORDER BY Erscheinungsdatum;

-- 5. Welche Recordlabel Aus welchem Land kommen
SELECT LandCode AS "Land Code", COUNT(*) AS "Anzahl Labels"
FROM recordlabel
GROUP BY LandCode
ORDER BY COUNT(*) DESC;


-- 6. Artist Name zusammen mit Label Name
SELECT AR.Kuenstlername AS "Künstlername", RL.Name AS "Label", RL.LandCode AS "Land Code"
FROM artist AS AR
JOIN recordlabel RL ON AR.LabelID = RL.ID; 

-- 7. Alle Tracks mit Album Titel und Artist Name
SELECT T.Titel AS "Track", AL.Titel AS "Album", AR.Kuenstlername AS "Artist"
FROM track T
JOIN album AL ON T.AlbumID = AL.ID
JOIN artist AR ON AL.ArtistID = AR.ID
ORDER BY AR.Kuenstlername, AL.Titel;

-- 8. Welche User haben welche Tracks gestreamt?
SELECT u.Benutzername, t.Titel AS "Track", se.Geraet AS "Gerät", se.Zeitstempel AS "Zeitstempel"
FROM stream_ereignis se
JOIN user u ON se.UserID = u.ID
JOIN track t ON se.TrackID = t.ID
ORDER BY se.Zeitstempel DESC;

-- 9. Die meistgestreamten Tracks (Top 10)
SELECT t.Titel AS "Titel", ar.Kuenstlername AS "Künstlername", COUNT(se.ID) AS "Streams"
FROM stream_ereignis se
JOIN track t ON se.TrackID = t.ID
JOIN album al ON t.AlbumID = al.ID
JOIN artist ar ON al.ArtistID = ar.ID
GROUP BY t.ID, t.Titel, ar.Kuenstlername
ORDER BY Streams DESC
LIMIT 10;

-- 10. Durchschnittliche Track Dauer pro Genre
SELECT al.Genre AS "Genre" ,COUNT(t.ID) AS AnzahlTracks, ROUND(AVG(t.Dauer_Sekunden) / 60, 2) AS DurchschnittDauer_Min, ROUND(SUM(t.Dauer_Sekunden) / 60, 1) AS GesamtDauer_Min
FROM TRACK t
JOIN ALBUM al ON t.AlbumID = al.ID
GROUP BY al.Genre
ORDER BY AnzahlTracks DESC;