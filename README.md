# NewsList

Feeding from "https://s3.amazonaws.com/shrekendpoint/news.json",

# Requirements
## JSON data
- Top level "data"
  - "type": "Section"
    - articles, videos, slideshows containing "tease", "label", and "headline". (and "id")


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
## Parsing: type for "Items" - enum vs NewsItem

Selecting NewsItem to parse "items" payload involves less code, but will require having more optionals in the NewsItem type as this tries to make everything a NewsItem regardless of type value.

selecting an codable enum, might seem like more code but has better sustainability and end up with a cleaner NewsItem structure with no optionals.



```
public struct DataItem: Codable {
	...
	public let items: [DataItemType]?    // 
```