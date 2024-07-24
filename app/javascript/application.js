// application.js

import "@hotwired/turbo-rails"
import "controllers"

// Import Bootstrap and Bootstrap Table
// import 'bootstrap';  // Import Bootstrap
// import 'bootstrap-table';  // Import Bootstrap Table

//import './table_sorting';  // Import your custom JavaScript

// Initialize bootstrap-table when the DOM is fully loaded
// document.addEventListener("DOMContentLoaded", () => {
//     console.log("DOM fully loaded and parsed");

//     if (typeof $ !== 'undefined' && $.fn.bootstrapTable) {
//       console.log("Bootstrap Table loaded");
//       $('.table').bootstrapTable({
//         columns: [
//         {
//           field: 'title',
//           title: 'Title',
//           sortable: true
//         },
//         {
//           field: 'description',
//           title: 'Description',
//           sortable: true
//         },
//         {
//           field: 'payout',
//           title: 'Payout',
//           sortable: true,
//           sorter: moneySorter // Register the custom sorter
//         },
//         {
//           field: 'status',
//           title: 'Status',
//           sortable: true
//         },
//         {
//           field: 'ageRange',
//           title: 'Age Range',
//           sortable: true
//         },
//         {
//           field: 'gender',
//           title: 'Target Gender',
//           sortable: true
//         },
//         {
//           field: 'claim',
//           title: 'Claim',
//           sortable: false
//         }
//       ]
//       });
//     } else {
//       console.error('jQuery or Bootstrap Table is not loaded');
//     }
//   });

