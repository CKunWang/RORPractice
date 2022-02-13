# RORPractice

This is an api that offer a platform for online lesson transaction.


## To start using api
##### environment
- Rails 5.0.7.2
- ruby 2.6.6p146

##### Initialize
Create your `databse.yml` to connect your database
```
touch config/database.yml
```
Add your database settings to `databse.yml`
```
production: 
  adapter: postgresql
  encoding: unicode
  database: your_db_production
  username: your_user
  password: your_password
```

Create your `secret.yml` to generate your `secret_key_base`
```
touch config/secret.yml
```
Add your secret_key_base ( your can use `rake secret` to generate key ) to `secret.yml`
```
production:
  secret_key_base: your_key
```

Your can set user token alive time in `config/environments/production.rb`, and change alive seconds
```
config.token_expire_second = your_seconds
```

Next, we are going to install gem and create database

```
bundle install
RAILS_ENV=production rake db:create
RAILS_ENV=production rake db:migrate
```

If your want to create admin role, you can edit `db/seeds.rb` and create admin role

(Because I use `devise` gem, **email must be email format, password's length must over 8** )
```
User.create! :email => 'admin@gmail.com', :password => '123456789', :password_confirmation => '123456789', :role=>'admin'
```

Then run `rake db:seed` to create role

Now, we have done the initial setting

Use `rails s -e production` to start server

## Offered apis

`POST /api/v0/login` offered user login function
```
curl -d "email=user_mail&password=user_password" -X POST http://localhost:3000/api/v0/login
```
return user_token


`POST /api/v0/signup/user` offer user sign up
```
curl -d "email=user_mail&password=user_password&password_confirmation=user_password" -X POST http://localhost:3000/api/v0/signup/user
```
return user_token


`POST /api/v0/lessons` allow admin new lesson
```
curl -H "Token: token" -d "subject=subject&currency=currency&price=price&lesson_type=lesson_type&is_available=is_available&url=url&description=description&expired_days=expired_days" -X POST http://localhost:3000/api/v0/lessons
```

`GET /api/v0/lessons` allow admin get all lessons
```
curl -H "Token: token" -X GET http://localhost:3000/api/v0/lessons
```

`PUT /api/v0/lessons/{lesson_id}` allow admin update lesson
```
curl -H "Token: token" -d "subject=subject&currency=currency&price=price&lesson_type=lesson_type&is_available=is_available&url=url&description=description&expired_days=expired_days" -X PUT http://localhost:3000/api/v0/lessons/{lesson_id}
```

`DELETE /api/v0/lessons/{lesson_id}` allow admin delete lesson
```
curl -H "Token: token" -X DELETE http://localhost:3000/api/v0/lessons/{lesson_id}
```


`GET /api/v0/lessons/available` allow user get available lesson list
```
curl -H "Token: token" -X GET http://localhost:3000/api/v0/lessons/available
```

`POST /api/v0/lessons/{lesson_id}/purchase` allow user purchase lesson
```
curl -H "Token: token" -X POST http://localhost:3000/api/v0/lessons/{lesson_id}/purchase
```

`GET /api/v0/lessons/purchased` allow user get purchased records
```
curl -H "Token: token" -d "lesson_type=lesson_type&available=available" -X GET http://localhost:3000/api/v0/lessons/purchased
```
