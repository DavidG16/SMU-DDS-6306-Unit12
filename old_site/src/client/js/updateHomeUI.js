function homeUI ()

 {

    let home = `
    
    <section class="profile-pic">
    <img class="profile-pic-pic" src="/assets/profile-pic/19814808.jpeg"> 
 </section>
 <section class="summary">
     <div class="name">
         <h1>David Grijalva</h1>
     </div>
     <div class="heading">
         <h2>Summary</h2>
         <div class="main-text">
             <p class="about">Product Lead with demonstrated experience in exploring data in order to 
                 create actionable insights and turning them into impactful results. 
                 Strongly passionate about product management, data science, machine learning and natural language processing. </p>
         </div>
     </div>
     <div class="work-experience">
         <h2> Work Experience</h2>
         <div class="main-text">
             <p class="institution-name">Indeed.com</p>
             <p class="position">Senior Product Lead</p>
         </div>
     </div>
     <div class="education">
         <h2>Education</h2>
         <div class="main-text">
             <p class="institution-name"> Southern Methodist University</p>
             <p class="position"> Master of Data Science</p>
             <p class="date">Graduation Date: May 2022</p>
         </div> 
     </div>
 </section>
 <section class="works">
     <div class="beer-study">
         <h2> Work Portfolio</h2>
         <div class="main-text">
             <button id="work-card-container-id" class="work-card">
                 <div  class="work-card-container">
                     <p class="work-title">Beer & Breweries Study</p>
                     <img class="works-item-svg" src="/assets/works/beer-svgrepo-com.svg">  
                 </div>
             </button>
         </div>
     </div>
 </section>
`

console.log("updateWorksUI is called")
document.getElementById("sub-container-id").innerHTML = home

}

export {

    homeUI
}