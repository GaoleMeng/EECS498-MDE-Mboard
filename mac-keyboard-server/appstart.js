function radioClicked() {
        console.log("fff")
        fetch("http://localhost:3000/toggle", { credentials: 'same-origin' })
          .then((response) => {
            if (!response.ok) throw Error(response.statusText);
            console.log("manage to toggle")
          })
          .catch(error => console.log(error)); // eslint-disable-line no-console
      }

