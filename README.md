# MedSage CSV Importing

This is a simplified version of a piece of functionality we have in medSage. Our customers are medical equipment companies, called DMES. DMEs (Durable Medical Equipment Company) use many different billing systems, some commercial, some homegrown, some are even just an excel spreadsheet. We give various options for synchronizing this data with medSage, one option is the DME can send us CSV files each time things change, and we'll process the CSV to make the appropriate changes in medSage.

Things you may want to cover:

* In this problem we're only going to consider three data types: Patients, Orders, and Invoices. Invoices is a join between Patients and Orders.

* patient columns: patient_id, patient_name, state

* order columns: order_id, category, state

* invoice columns: patient_id, order_id, state

* For all data types, state is in ['active', 'deleted']. The patient_id and order_id are globally unique, so a new id means a new record, an id they've seen before means an update to an existing record.

* You should write a program that processes the files in order. You'll need to determine the type of data in the csv based on the headers in the first row. At the end, you need to spit out a list of active orders, and for each order a list of active patients with active invoices in that order. You only have to display the order category, and for patients, the name of the patient is fine in the list.

* Watch out for quoting problems if you try to parse the CSVs by hand

* An active invoice might point to a deleted patient, and invoices may be deleted as well.

* Column order in the CSV is unspecified, one patient csv may be ordered differently than the next.

* Write automated tests that you think are acceptable to cover the expected behavior as if this was being pushed out to production.

* The frontend doesn't have to be flashy, but since we're a web app, we expect the UI to be in the form of a web page.

* The UI does not need to be editable, just display it read-only.

* Some of the invoices are invalid (reference non-existing patient or order).


### Using value converters

```
class IdConverter
 def self.convert(value)
  value[0]=''
  value
  end
end

filename='/tmp/file.csv'

options={value_converters: {order_id: IdConverter, patient_id: IdConverter}}

data=SmarterCSV.process(filename, options)
```

## License

Source code released under the [GNU General Public License](http://www.gnu.org/licenses/gpl-3.0.html) as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. Docs released under a [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/).

[![GPL V3](http://www.gnu.org/graphics/gplv3-88x31.png)](http://www.gnu.org/licenses/gpl-3.0.html) [![Creative Commons License](https://i.creativecommons.org/l/by/4.0/88x31.png)](http://creativecommons.org/licenses/by/4.0/)
