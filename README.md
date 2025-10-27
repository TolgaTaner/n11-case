#  N11 Case Study

This project is an iOS sample application developed for the **N11 Case Study**.  
It demonstrates product listing and product detail flows, including both **sponsored** and **regular** product displays.

---

##  Overview

The goal of this case study is to implement:

- **Sponsored products** displayed horizontally,  
- **Regular products** displayed in a **2-column grid layout** with **pagination**,  
- Navigation to a **product detail screen** when a product is tapped,  
- A simple **product detail page** built using the data returned from the product detail endpoint.

---

## Technical Details

This project is built **entirely programmatically** (no Storyboards or XIBs).

### Technologies Used
- **UIKit**
- **Programmatic Layout**
- **URLSession** for networking
- **Codable** for JSON parsing
- **VIPER architecture**
- **XCTest / XCUITest** for unit and UI testing

---

###  Product List
- Displays total results, sorting, and filter options at the top.  
- The first section contains **sponsored products** shown in a horizontal `UICollectionView`.  
- The next section lists **regular products** using a 2-column grid layout.  
- **Pagination** is supported for loading more products.

### Product Detail
- When a product is tapped, its **detail endpoint** is called.  
- The response data (image, name, price, etc.) is displayed in a simple product detail layout.

---

## Tests

The project includes both **unit** and **UI test** suites.

- The `ProductListPage` class validates the existence of key UI components.  
---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/TolgaTaner/n11-case.git
   cd n11-case
