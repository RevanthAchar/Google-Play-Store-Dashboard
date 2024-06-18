
--finding and deleting nulls

delete from googleplaystore where 
app is null
or Category is null
or Rating is null
or Reviews is null
or size is null
or installs is null
or type is null
or price is null
or Content_Rating is null
or Genres is null
or Last_Updated is null
or Android_Ver is null


--overall view of datasets

select count(distinct(app)) as total_app_count,
count(distinct(category)) as total_category_count from googleplaystore

--top 5 apps and categories

select top 5 category,
count(app) as total_count from googleplaystore
group by Category
order by total_count desc

--top 10 rated free apps

select TOP 10
app, category, rating, reviews from googleplaystore
where type = 'Free' and RATING <> 'NaN'
order by rating desc

--most reviewed app

select app, reviews from googleplaystore
order by reviews desc


--Average ratings by category

select category, avg(try_cast(rating as float)) as avg_rating from googleplaystore
group by Category
order by avg_rating desc

--top number of installs by category

select category, 
sum(cast(replace(substring(installs,1, patindex('%[^0-9]%', installs + ' ')-1), ',', ' ') as int)) 
as total_intsalls from googleplaystore
group by Category
order by total_intsalls desc

--Average sentiment polarity by app category

select category,
avg(try_cast(sentiment_polarity as float)) as avg_sentiment_polarity
from googleplaystore
inner join
googleplaystore_user_reviews
on googleplaystore.app = googleplaystore_user_reviews.App
group by Category
order by avg_sentiment_polarity desc

--sentiment reviews by app category

select category, 
sentiment,
count(*) as total_count from googleplaystore
inner join
googleplaystore_user_reviews
on googleplaystore.app = googleplaystore_user_reviews.app
where Sentiment <> 'nan'
group by Category, Sentiment
order by total_count desc

