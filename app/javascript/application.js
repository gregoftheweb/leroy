// application.js

import "@hotwired/turbo-rails"
import "controllers"

// Import Bootstrap and Bootstrap Table
import 'bootstrap';  // Import Bootstrap
import 'bootstrap-table';  // Import Bootstrap Table

import './table_sorting';  // Import your custom JavaScript

// Initialize bootstrap-table when the DOM is fully loaded
document.addEventListener("DOMContentLoaded", () => {
  if (typeof $ !== 'undefined') {
    $('.table').bootstrapTable();
  } else {
    console.error('jQuery is not loaded');
  }
});
