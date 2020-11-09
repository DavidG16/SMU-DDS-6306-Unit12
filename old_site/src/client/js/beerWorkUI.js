function updateWorksUI ()

 {

    let works = `
    
    <section>
        
            <button id="r-knit" class="work-card">
            
                <div class="work-card-container">
                    <p class="work-title">Beer & Breweries Study R Knit Code</p>
                    <img class="works-item-svg" src="/assets/works/1448px-R_logo.svg.png">  
                </div>
            
            </button>

            <button id="rShinny" class="work-card">
            <a href="https://dgrijalva.shinyapps.io/BeerStudyApp/"  target="_blank">
                <div class="work-card-container">
                    <p class="work-title">Beer & Breweries Study R Shinny App</p>
                    <img class="works-item-svg" src="/assets/works/shiny.png">  
                </div>
            </a>
            
            </button>    
            

      
    </section>
`

console.log("updateWorksUI is called")
document.getElementById("sub-container-id").innerHTML = works

}

export {

    updateWorksUI
}