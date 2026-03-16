# Dokumentation Modul 164
<img src="./Apple%20Music%20Light.png" />

## Zweck der Datenbank

Unser Projekt war es, den Musik-Streamingdienst Apple Music nachzubauen (besser gesagt Apple Music Light, da der ganze Streamingdienst den Rahmen sprengen würde). Apple Music Light soll Tracks, Alben, Künstler, Musik-Label, User und deren Aktivitäten festhalten. Dazu wurden insgesamt sieben Tabellen genutzt.

Der genaue Geschäftsprozess sieht so aus: Plattenlabels haben Künstler unter Vertrag. Diese Künstler bringen Alben heraus, auf denen sich Tracks befinden. Weil in der Musikindustrie oft mehrere Künstler an einem Song arbeiten, muss das System auch Feature-Gäste festhalten können. Endbenutzer (User) können sich registrieren und Tracks abspielen. Die Datenbank speichert ab, wer welchen Song wann und auf welchem Gerät gehört hat (Streaming-Historie).

## Eingesetztes Datenbankmanagementsystem

Wir haben uns für das DBMS MariaDB entschieden. Zuerst wollten wir MySQL nutzen, aber da nicht alle Teilnehmer der Gruppe MySQL kannten und die Lernkurve bei MySQL relativ steil ist, fiel die Entscheidung auf MariaDB. MariaDB bietet für dieses Projekt die gleichen Funktionen, war für uns aber effizienter umzusetzen.

## Beschreibung der Tabellen und Beziehungen

Die Datenbank besteht aus sieben Tabellen. So können wir alle Anforderungen abbilden und Redundanzen vermeiden (3. Normalform).

**Die Tabellen:**

- **RECORDLABEL:** Speichert die Plattenfirmen (Name und Land).
- **ARTIST:** Speichert die Künstler und ihre Biografie.
- **ALBUM:** Speichert die Alben (Titel, Genre, Release-Datum).
- **TRACK:** Speichert die einzelnen Lieder und wie lange sie dauern (in Sekunden).
- **USER:** Speichert unsere registrierten Benutzer (Username, E-Mail, Abo-Preis).
- **TRACK_FEATURE (Zwischentabelle):** Brauchen wir, wenn mehrere Künstler an einem Track beteiligt sind (Features).
- **STREAM_EREIGNIS (Zwischentabelle):** Speichert jeden Stream. Hier wird festgehalten, welcher User welchen Track wann und auf welchem Gerät abgespielt hat.

**Die Beziehungen:**

- **1:m (Album zu Track):** Ein Album hat mehrere Tracks. Ein Track gehört aber immer zu genau einem Album.
- **c:m (Recordlabel zu Artist):** Ein Label hat mehrere Künstler. Ein Künstler hat im System maximal ein Label, er kann aber auch unabhängig sein (0 oder 1).
- **m:m ohne Attribute (Artist zu Track):** Ein Track kann mehrere Feature-Gäste haben. Ein Künstler kann auf mehreren fremden Tracks als Feature mitwirken. Das lösen wir über die Tabelle `TRACK_FEATURE`.
- **m:m als Ereignis (User zu Track):** Ein User hört viele Tracks, ein Track wird von vielen Usern gehört. Das speichern wir in der Tabelle `STREAM_EREIGNIS` zusammen mit den Attributen Zeitstempel und Gerät.

## Konzeptionelles Datenmodell

Das konzeptionelle Datenmodell zeigt die Übersicht unserer Tabellen und wie sie zusammenhängen. Es enthält noch keine Fremdschlüssel oder Datentypen, da es unabhängig vom DBMS ist.


## Logisches Datenmodell

Das logische Datenmodell leitet sich aus dem konzeptionellen Entwurf ab. Es befindet sich in der 3. Normalform (3. NF) und enthält alle Details, die wir für das SQL-Skript brauchten: Primärschlüssel (PK), Fremdschlüssel (FK), Datentypen und die Zwischentabellen für unsere m:m-Beziehungen.

