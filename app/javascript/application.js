// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  var lastFocus = null

  document.querySelector(".modal-opener").addEventListener("click", () => {
    const nonModal = document.querySelector(".non-modal")
    const modal = document.querySelector(".modal-container")
    
    modal.classList.remove('not-displayed')
    lastFocus = document.activeElement
    const firstButton = modal.querySelector("button")
    if (firstButton) firstButton.focus()
    return nonModal.setAttribute('aria-hidden', true)
  })
  
  document.querySelector(".modal-closer").addEventListener("click", () => {
    const modal = document.querySelector(".modal-container")
    
    modal.classList.add('not-displayed')
    if (lastFocus) lastFocus.focus()
    return nonModal.setAttribute('aria-hidden', false)
  })
  
  document.querySelector("#teams_number").addEventListener("change", () => {
    const teamsNumber = document.querySelector("#teams_number").value
    const teams = document.querySelector("#teams")
    teams.innerHTML = `<h4 class="margin-none padding-bottom-xxs">Nom des équipes</h2>`
  
    for (let i = 0; i < teamsNumber; i++) {
      const team = document.createElement("div")
      team.classList.add("flex", "justify-between", "align-center", "flex-gap-s")
      team.innerHTML = `
        <label for="event[teams_attributes][][name]">Équipe ${i + 1}</label>
        <input type="text" name="event[teams_attributes][][name]" id="event[teams_attributes][][name]" placeholder="Équipe ${i + 1}" />
      `
      teams.appendChild(team)
    }
  
    console.log(teamsNumber % 2)
  
    if (teamsNumber % 2 === 0) {
      const workshops = document.querySelector("#workshops")
      workshops.innerHTML = `<h4 class="margin-none padding-bottom-xxs">Nom des ateliers</h2>`

      for (let i = 0; i < teamsNumber / 2; i++) {
        const workshop = document.createElement("div")
        workshop.classList.add("flex", "justify-between", "align-center", "flex-gap-s")
        workshop.innerHTML = `
          <label for="event[workshop_attributes][][name]">Atelier ${i + 1}</label>
          <input type="text" name="event[workshop_attributes][][name]" id="event[workshop_attributes][][name]" placeholder="Atelier ${i + 1}" />
        `
        workshops.appendChild(workshop)
      }
    }
  })
})

