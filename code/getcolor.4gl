globals "globals.4gl"

function GetColor(inBrand, inOption, dispOption)
define
   inBrand like brands.b_id,
   inOption smallint,
   dispOption smallint,

   inActiveColor char(16),
   ActiveColor char(16),
   colorStr char(16),
   textcolorStr char(16)

{
   WSActiveColor char(16),
   WSinActiveColor char(16),
   WSTextColor char(16),
   IMActiveColor char(16),
   IMinActiveColor char(16),
   IMTextColor char(16),
   TIActiveColor char(16),
   TIinActiveColor char(16),
   TITextColor char(16),
   RAActiveColor char(16),
   RAinActiveColor char(16),
   RATextColor char(16),
   LOActiveColor char(16),
   LOinActiveColor char(16),
   LOTextColor char(16),
   BAActiveColor char(16),
   BAinActiveColor char(16),
   BATextColor char(16),
   SEActiveColor char(16),
   SEinActiveColor char(16),
   SETextColor char(16),
   ISActiveColor char(16),
   ISinActiveColor char(16),
   ISTextColor char(16)
}
{
let WSActiveColor = 'rgb(190,130,251)'
let WSinActiveColor = 'rgb(221,160,221)'
let WSTextColor = 'rgb(0,0,0)'

let IMActiveColor = "rgb(0,255,0)"
let IMinActiveColor = "rgb(150,235,150)"
let IMTextColor = 'rgb(0,0,0)'

let TIActiveColor = 'rgb(255,0,0)'
let TIinActiveColor = 'rgb(240,128,128)'
let TITextColor = 'rgb(255,255,255)'

let RAActiveColor = 'rgb(45,161,239)'
let RAinActiveColor = 'rgb(130,202,251)'
let RATextColor = 'rgb(0,0,0)'

let LOActiveColor = 'rgb(255,255,0)'
let LOinActiveColor = 'rgb(242,245,169)'
let LOTextColor = 'rgb(0,0,0)'

let BAActiveColor = 'rgb(160,156,156)'
let BAinActiveColor = 'rgb(236,236,236)'
let BATextColor = 'rgb(0,0,0)'

let SEActiveColor = 'rgb(160,156,156)'
let SEinActiveColor = 'rgb(236,236,236)'
let SETextColor = 'rgb(0,0,0)'

let ISActiveColor = 'rgb(160,156,156)'
let ISinActiveColor = 'rgb(236,236,236)'
let ISTextColor = 'rgb(0,0,0)'
}

if(inOption = dispOption or inOption=0) then
   let colorStr = G_ActiveColor
   let textcolorStr = G_TextColor
else
   let colorStr = G_inActiveColor
   let textcolorStr = G_TextColor
end if

{
case inBrand
   when 'WS'
      if(inOption = dispOption or inOption=0) then
         let colorStr = WSActiveColor
         let textcolorStr = WSTextColor
      else
         let colorStr = WSinActiveColor
         let textcolorStr = WSTextColor
      end if
   when 'IM'
      if(inOption = dispOption or inOption=0) then
         let colorStr = IMActiveColor
         let textcolorStr = IMTextColor
      else
         let colorStr = IMinActiveColor
         let textcolorStr = IMTextColor
      end if
   when 'TI'
      if(inOption = dispOption or inOption=0) then
         let colorStr = TIActiveColor
         let textcolorStr = TITextColor
      else
         let colorStr = TIinActiveColor
         let textcolorStr = TITextColor
      end if
   when 'RA'
      if(inOption = dispOption or inOption=0) then
         let colorStr = RAActiveColor
         let textcolorStr = RATextColor
      else
         let colorStr = RAinActiveColor
         let textcolorStr = RATextColor
      end if
   when 'LO'
      if(inOption = dispOption or inOption=0) then
         let colorStr = LOActiveColor
         let textcolorStr = LOTextColor
      else
         let colorStr = LOinActiveColor
         let textcolorStr = LOTextColor
      end if
   when 'BA'
      if(inOption = dispOption or inOption=0) then
         let colorStr = BAActiveColor
         let textcolorStr = BATextColor
      else
         let colorStr = BAinActiveColor
         let textcolorStr = BATextColor
      end if
   when 'SE'
      if(inOption = dispOption or inOption=0) then
         let colorStr = SEActiveColor
         let textcolorStr = SETextColor
      else
         let colorStr = SEinActiveColor
         let textcolorStr = SETextColor
      end if
   when 'IS'
      if(inOption = dispOption or inOption=0) then
         let colorStr = ISActiveColor
         let textcolorStr = ISTextColor
      else
         let colorStr = ISinActiveColor
         let textcolorStr = ISTextColor
      end if
end case
}
#display inOption, dispOption, colorStr

return colorStr, textcolorStr

end function

