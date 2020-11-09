function rKnit() {

    let pdf = `
    <embed
    src="/assets/pdf/Apurv_David_DS_Project_1.html.pdf"
    type="application/pdf"
    frameBorder="0"
    scrolling="auto"
    height="1000px"
    width="1200px"></embed>
    
    
    `
document.getElementById("sub-container-id").innerHTML = pdf
}

export {

    rKnit
}