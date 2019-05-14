 <template id="template-cell">
   <div id="cell">
     <td class="number">{{ value.BanKham }}</td>
     <td class="number">{{ value.PhongKham }}</td>
     <td> {{ value.HovaTen }}</td>
   </div>
 </template>
 <script>
   export default {
     name: 'row-value',
     props: ['value', 'vindex', 'rindex']
   }
 </script>