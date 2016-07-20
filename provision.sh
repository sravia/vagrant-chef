export ANT_OPTS="-Xmx1024m -XX:MaxPermSize=512m"


mysql -u root -ptest -e "DROP DATABASE test;"
mysql -u root -ptest -e "CREATE DATABASE test;"
#mysql -u root -ptest test < /vagrant/data/test.sql
