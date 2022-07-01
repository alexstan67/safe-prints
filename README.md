# Introduction

<img src="https://github.com/alexstan67/safe-prints/blob/master/app/assets/images/SafePrintsFullLogo.png" width="200" />

Rails **MOBILE** app generated during Le Wagon Boot camp in Bali 2022, final project. Team was Riza Santoso, Glen Smith and Alexandre Stanescot (lead).

# Safe Prints

**A Community Keeping Travellers Safe**

Safe Prints can be used by inexperienced travelers, as well as fellow travelers that care about their safety.

Thanks to search bar, you can indicate the place you are, or want to visit. The community can post incident reports that are categorized as:
* Road accident
* Mugging
* Pickpocket
* Sexual Harassment
* Scams
* Robbery
* Others

Reviews about reports can also be provided by the community, either by leaving a comment, or by voting to acknowledge the incident.

On the map, new reports are distinguished from older reports through the opacity of the pins.

## Requirements
* ruby 3.0.3
* rails 6.1.6
* bundler

## Installation
Create a .env file with following keys:
`MAPBOX_API_KEY=`
`CLOUDINARY_URL=`

`bundle install`

`yarn`

Modifiy `config/database.yml` following your requirements (default one works)

`rails db:create`

`rails db:migrate`

`rails db:seed` for demo purpose.

## Usage

Connect with one of the fictive users:
* alex.stan@gmail.com     | 12345678
* riza.santoso@gmail.com  | 12345678
* glen.smith@gmail.com    | 12345678

For demo purpose, we worked the following destinations:
* Canggu, Bali
* Kuta, Bali

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
