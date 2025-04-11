   CALL RETRIEVE_ALL;

   CALL UPDATE_SALEPRICE(1, 'BAD');

   CALL RETRIEVE_ALL;
   
-----------------------------------------------
   
   CALL RETRIEVE_ALL;

   CALL UPDATE_SALEPRICE(3, 'WORSE');

   CALL RETRIEVE_ALL;