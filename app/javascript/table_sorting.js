// app/javascript/table_sorting.js

// console.log("table sorter loaded");

// function moneySorter(a, b) {
//     // Remove currency symbols and commas, then convert to float
//     console.log("fired the sorter");
//     var aValue = parseFloat(a.replace(/[^0-9.-]+/g, ''));
//     var bValue = parseFloat(b.replace(/[^0-9.-]+/g, ''));
//     return aValue - bValue;
//   }
  
  
// // Initialize bootstrap-table when the DOM is fully loaded
// document.addEventListener("DOMContentLoaded", () => {
//     console.log("DOM fully loaded and parsed");
  
//     if (typeof $ !== 'undefined' && $.fn.bootstrapTable) {
//       console.log("Bootstrap Table loaded");
//       $('.table').bootstrapTable({
//         columns: [{
//           field: 'payout',
//           sorter: moneySorter // Register the custom sorter
//         }]
//       });
//     } else {
//       console.error('jQuery or Bootstrap Table is not loaded');
//     }
//   });