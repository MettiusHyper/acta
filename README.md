<img src="https://github.com/MettiusHyper/acta/blob/main/images/icon.png?raw=true" alt="logo" width="150"/>

# Acta

A productivity app, with many tools contained in a single package.


## Screenshots

<div style="text-align: center"><table><tr>
  <td style="text-align: center">
    <img src="https://github.com/MettiusHyper/acta/blob/main/images/Home.png?raw=true" alt="Home page" width="200"/>
  </td>
  <td style="text-align: center">
    <img src="https://github.com/MettiusHyper/acta/blob/main/images/Add%20Task.png?raw=true" alt="Add task" width="200"/>
  </td>
  <td style="text-align: center">
    <img src="https://github.com/MettiusHyper/acta/blob/main/images/Home%20Dark.png?raw=true" alt="Home page dark theme" width="200"/>
  </td>
</tr></table></div>

## Development

Acta uses Firebase for authentication with google auth, then it uses the secure token that is given by firebase in order to make requests to an express server which stores data in a mongodb database.

The app uses two StreamProvider, one for handling the firebase user, and one that represents the data for the user that is stored in the mongodb database.
