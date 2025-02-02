# Ecommerce Item Utility for Google Tag Manager

Ecommerce Item Utility is a custom variable template designed for Google Tag Manager (GTM). This versatile tool allows you to check the presence of specific products or retrieve product details from an array of ecommerce items using exact or partial attribute matching.

## Features
- **Check Product Presence**: Determine if a product with specific attributes exists in an array.
- **Retrieve Product Details**: Extract product objects that match defined criteria.
- **Flexible Matching Options**: Supports exact match and contains (partial match) checks.
- **Easy Configuration**: Customizable fields for attribute names, filter values, and output preferences.

## How to Configure in GTM
1. **Import the Template**:
   - Download the `.tpl` file from this repository.
   - In GTM, go to **Templates** > **New Variable Template** > **Import** and upload the file.

2. **Add a New Variable**:
   - Navigate to **Variables** > **New** > **Choose a Variable Type** > **Custom Templates**.
   - Select the imported template, **Ecommerce Item Utility**.

3. **Configure the Fields**:
   - Fill in the following fields to set up the variable:
     - **Item Object Variable**: Specify the variable containing the array of ecommerce items (e.g., `{{dlv - ecommerce.items}}`).
     - **Custom Key Name**: Enter the attribute key you want to evaluate (e.g., `item_name`).
     - **Filter Value**: Provide the value to match against the attribute key.
     - **Type of Matching Check**: Choose between `Exact Match` or `Contains`.
     - **Action Output**: Select either `Check Product Presence` or `Retrieve Product Details`.

4. **Use the Variable**:
   - Use the configured variable in your tags, triggers, or other variables for ecommerce tracking or filtering.

## Input Configuration and Output Examples

| **Field**                 | **Description**                                                                 | **Example Input**                      | **Example Output**                      |
|---------------------------|---------------------------------------------------------------------------------|----------------------------------------|-----------------------------------------|
| `customItemObjVar`        | Variable containing the array of ecommerce items.                               | `{{dlv - ecommerce.items}}`            | `[{"item_name": "Shoe", "item_id": 1}]` |
| `customItemObjectKeyVar`  | The attribute key to evaluate.                                                  | `item_name`                            | -                                       |
| `itemValueEvaluation`     | The value to match against the key.                                             | `Shoe`                                 | -                                       |
| `matchingType`            | Type of matching: `Exact Match` or `Contains`.                                  | `Exact Match`                          | -                                       |
| `computeOutput`           | Output type: `Check Product Presence` or `Retrieve Product Details`.            | `Check Product Presence`               | `true` (if product exists)             |
| **Example Result**        | Based on configuration and input values.                                        | -                                      | `true` (for presence) or `[object]`    |

## License
This project is licensed under the [MIT License](LICENSE).

## Feedback and Contributions
Feel free to open an issue or submit a pull request if you have suggestions or improvements. Contributions are welcome!
