 <template id="template-cell">
   <div id="cell">
     <td class="number">{{ value.Table }}</td>
     <td class="number">{{ value.Room }}</td>
     <td> {{ value.Name }}</td>
   </div>
 </template>
 <script>
   export default {
     name: 'row-value',
     props: ['value', 'vindex', 'rindex']
   }
 </script>