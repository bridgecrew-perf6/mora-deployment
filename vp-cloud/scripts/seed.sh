echo "seeding database with ..."
mongo <<EOF
use video-server
db.user.insert(
{
        "_id" : ObjectId("626ae81e9795d602627f3c9a"),
        "username" : "root",
        "password" : "$2a$10$Xl4JXy5Hq0dwszrDB7Lc5OyRTTrEueGVhO3gauui/OHKRN6dlxJ0q",
        "roles" : [
                "USER"
        ],
        "_class" : "com.arenalocastro.videomanagement.models.User"
})
EOF

