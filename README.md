# NewsList

Feeding from "https://s3.amazonaws.com/shrekendpoint/news.json", do the following.

# Requirements
## JSON data
- Top level "data", filter on type "Section". Display UI as described below.


## UI
List news in a following way:

- first item distict visual style
- next items:
  - 2 items per row for phones
  - 3 items per row for tablets
- each row:
  - tease image
  - headline text
  - summary: 2 lines on screen. ellipsizing if neccessary

# Decision making
## Parsing: Using JSON as [String: Any] vs. Serialize into Objects
Although using json as [String: Any] might be less code, serializing into objects result in a much cleaner code for other sub-system.
Thus, serializing into codable objects were used.

## Parsing: data > items serialization  
Forcing "items" to be of a defined NewsItem type involves less API coding. However, it will result in having more optionals for sub-systems that use NewsItem instance.
Using codable enum to handle this has more code in API, but results in a much cleaner code for other sub-system, as well as have a flexibility to add more types in future.

## UI: Multiple sections vs Header
Using compositional layout, in order to have first item stand out, we can choose either of :
1. Using sections and divide main section versus rest
2. Have the standout in a supplementary view. 
(1) was chosen as funcionality-wise, all cells are the same and I would like to re-use the code.


