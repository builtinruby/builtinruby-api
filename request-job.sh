curl -XPOST -i https://builtinruby-api.herokuapp.com/jobs -d 'title=Software Developer at Company' -d 'company=Company' -d 'role=Software Developer' -d 'level=Senior' -d 'location=Remote' -d 'employment_term=CLT' -d 'pay_rate=A combinar' -d 'website=http://company.com' -d 'tags[]=ruby' -d 'tags[]=rails' -d 'description=Hello description' -d 'requirements=Hello requirements' -d 'benefits=Hello benefits' -d 'how_to_apply=Hello How to apply'

curl -XPOST -i  https://builtinruby-api.herokuapp.com/api/v1/jobs \
  -d 'title=Software Developer at Company' \
  -d 'company=Company' \
	-d 'role=Software Developer' \
	-d 'level=Senior' \
	-d 'location=Remote' \
	-d 'employment_term=CLT' \
	-d 'pay_rate=A combinar' \
	-d 'website=http://company.com' \
	-d 'tags[]=ruby' \
	-d 'tags[]=rails' \
	-d 'description=Hello description' \
	-d 'requirements=Hello requirements' \
	-d 'benefits=Hello benefits' \
	-d 'how_to_apply=Hello How to apply'

curl -XPOST -i http://localhost:3000/api/v1/jobs \
  -d 'title=Software Developer at Company' \
  -d 'company=Company' \
	-d 'role=Software Developer' \
	-d 'level=Senior' \
	-d 'location=Remote' \
	-d 'employment_term=CLT' \
	-d 'pay_rate=A combinar' \
	-d 'website=http://company.com' \
	-d 'tags[]=ruby' \
	-d 'tags[]=rails' \
	-d 'description=Hello description' \
	-d 'requirements=Hello requirements' \
	-d 'benefits=Hello benefits' \
	-d 'how_to_apply=Hello How to apply'


curl -XPOST -i http://localhost:3000/api/v1/companies \
  -d 'title=Company' \
  -d 'category=Marketing' \
  -d 'founded_at=2010' \
  -d 'logo=picture.png' \
  -d 'location=Florianópolis' \
  -d 'website=http://company.com' \
  -d 'blog=http://blog.company.com' \
  -d 'github=company' \
  -d 'linkedin=company'


