var commonModule = require('./common.js');

tp('Tasks')
  // or else only 25 are got
  .take('1000')
  .where('(Id gte ' + start_id + ') and (Id lte ' + end_id + ')')
  .sortByDesc('Id')
  .append('Comments-Count, MasterRelations-Count, SlaveRelations-Count, InboundAssignables-Count, OutboundAssignables-Count, Attachments-Count, Assignments-Count, Impediments-Count, Times-Count')
  .then(function(err,entities) {
     printEntities(err,entities)
   })
