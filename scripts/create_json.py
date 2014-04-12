import sys
import json
import sqlite3

MEMBER_TABLES = {
    #   Table : has_primary
    'Address' : True,
    'Phone'   : True,
    'EMail'   : True,
    'Website' : False
}

def get_member_table(db, table, memberid):
    assert table in MEMBER_TABLES

    query = "SELECT * FROM {table} WHERE memberid = ?"
    if MEMBER_TABLES[table]:
        query += " ORDER BY isprimary DESC"

    data = [dict(r) for r in db.execute(query.format(table=table), (memberid,))]
    for d in data:
        d.pop('memberid')

    return data
#
# main
#
if len(sys.argv) < 2:
    sys.exit("usage: {prog} DATABASE".format(prog=sys.argv[0]))

db = sqlite3.connect(sys.argv[1])
db.row_factory = sqlite3.Row

members = []
rows = db.execute("""
        SELECT memberid, firstname, lastname, nickname,
               strftime('%d.%m.%Y', birthday) as birthday, status, function
          FROM Member
      ORDER BY memberid ASC
""")

for row in rows:
    member = dict(row)
    for table in MEMBER_TABLES:
        member[table.lower()] = get_member_table(db, table, member['memberid'])
    members.append(member)

json.dump({"members":members}, sys.stdout, indent=4, separators=(',', ' : '))
