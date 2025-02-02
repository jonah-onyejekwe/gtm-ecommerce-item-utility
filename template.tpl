___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Ecommerce Item Utility",
  "description": "A versatile GTM variable for checking product presence or retrieving product details from an array using exact or partial attribute matching.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "customItemObjVar",
    "displayName": "Item Object Variable",
    "simpleValueType": true,
    "help": "Specify the variable containing the custom item object to be used.",
    "valueHint": "e.g., {{dlv - ecommerce.items}}"
  },
  {
    "type": "TEXT",
    "name": "customItemObjectKeyVar",
    "displayName": "Custom Key Name",
    "simpleValueType": true,
    "valueHint": "e.g., item_variant_id",
    "help": "Enter the custom key in the item object that you want to target."
  },
  {
    "type": "TEXT",
    "name": "itemValueEvaluation",
    "displayName": "Filter Value",
    "simpleValueType": true,
    "help": "Specify the value of the key in the item object that you want to filter or evaluate.",
    "valueHint": "e.g., product name"
  },
  {
    "type": "RADIO",
    "name": "matchingType",
    "displayName": "Type of Matching Check",
    "radioItems": [
      {
        "value": "exactMatchCheck",
        "displayValue": "Exact Match"
      },
      {
        "value": "containsMatchCheck",
        "displayValue": "Contains"
      }
    ],
    "simpleValueType": true,
    "help": "How the matching should be done."
  },
  {
    "type": "RADIO",
    "name": "computeOutput",
    "displayName": "Action Output",
    "radioItems": [
      {
        "value": "itemPresenceStatus",
        "displayValue": "Check Product Presence"
      },
      {
        "value": "retrieveProductObject",
        "displayValue": "Retrieve Product Details"
      }
    ],
    "simpleValueType": true,
    "help": "Select the operation: check for the product\u0027s presence, retrieve its details, or calculate its quantity."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const getType = require('getType');
const makeString = require('makeString');
const JSON = require('JSON');

// Input variables
const customItemObjVar = data.customItemObjVar;
const customItemObjectKeyVar = makeString(data.customItemObjectKeyVar);
const itemValueEvaluation = makeString(data.itemValueEvaluation);
const matchingType = makeString(data.matchingType); // Get the matching type from the radio button
const computeOutput = makeString(data.computeOutput); // Get the desired output type

// Check if customItemObjVar is an array using getType
const isArray = getType(customItemObjVar) === 'array';

// If customItemObjVar is not an array, return an appropriate default based on computeOutput
if (!isArray) {
  return computeOutput === 'itemPresenceStatus' ? false : [];
}

// Normalize the evaluation value for case-insensitive comparison
const normalizedValue = itemValueEvaluation.toLowerCase();

// Initialize variables for tracking results
let found = false; // Used for presence status
const matchedItems = []; // Used for retrieving matching objects

// Iterate through the array
customItemObjVar.forEach(function(item) {
  if (computeOutput === 'itemPresenceStatus' && found) return; // Stop further iteration for presence check if found

  // Safely access the value of the target key
  const value = item[customItemObjectKeyVar];

  if (value) {
    const normalizedItemValue = makeString(value).toLowerCase();

    // Perform the matching based on the selected matching type
    const isMatch =
      (matchingType === 'exactMatchCheck' && normalizedItemValue === normalizedValue) ||
      (matchingType === 'containsMatchCheck' && normalizedItemValue.indexOf(normalizedValue) !== -1);

    if (isMatch) {
      if (computeOutput === 'itemPresenceStatus') {
        found = true; // Set flag to true for presence check
      } else if (computeOutput === 'retrieveProductObject') {
        matchedItems.push(item); // Add matching object to the result array
      }
    }
  }
});

// Return results based on computeOutput
return computeOutput === 'itemPresenceStatus' ? found : matchedItems;


___TESTS___

scenarios: []


___NOTES___

Created on 1/28/2025, 11:03:26 AM


