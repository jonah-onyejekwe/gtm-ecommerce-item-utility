___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_NFPXH",
  "version": 1,
  "displayName": "Ecommerce Item Utility",
  "categories": [
    "UTILITY"
  ],
  "description": "A versatile GTM variable for checking product presence or retrieving product details from an array using exact or partial attribute matching.",
  "containerContexts": [
    "WEB"
  ],
  "securityGroups": []
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
    "type": "PARAM_TABLE",
    "name": "itemValueEvaluationTable",
    "displayName": "Filter Value",
    "paramTableColumns": [
      {
        "param": {
          "type": "TEXT",
          "name": "itemValueEvaluationColumn",
          "displayName": "Filter Value",
          "simpleValueType": true,
          "valueHint": "e.g., product name",
          "help": "Enter the value to filter based on the specified attribute."
        },
        "isUnique": false
      }
    ],
    "help": "Add multiple rows to define filter values for the specified attributes."
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
const matchingType = makeString(data.matchingType);
const computeOutput = makeString(data.computeOutput);

// Extract all filter values from the param table
const itemValueEvaluationArray = (data.itemValueEvaluationTable || []).map(row => makeString(row.itemValueEvaluationColumn).toLowerCase());

// Check if customItemObjVar is an array
const isArray = getType(customItemObjVar) === 'array';
if (!isArray) {
  return computeOutput === 'itemPresenceStatus' ? false : [];
}

let found = false;
const matchedItems = [];

// Iterate through the array
customItemObjVar.forEach(function(item) {
  if (computeOutput === 'itemPresenceStatus' && found) return;

  const value = item[customItemObjectKeyVar];
  if (value) {
    const normalizedItemValue = makeString(value).toLowerCase();

    // Check if any of the filter values match based on the selected type
    const isMatch = itemValueEvaluationArray.some(filterValue =>
      (matchingType === 'exactMatchCheck' && normalizedItemValue === filterValue) ||
      (matchingType === 'containsMatchCheck' && normalizedItemValue.indexOf(filterValue) !== -1)
    );

    if (isMatch) {
      if (computeOutput === 'itemPresenceStatus') {
        found = true;
      } else if (computeOutput === 'retrieveProductObject') {
        matchedItems.push(item);
      }
    }
  }
});

return computeOutput === 'itemPresenceStatus' ? found : matchedItems;


___TESTS___

scenarios: []


___NOTES___

Created on 1/28/2025, 11:03:26 AM


