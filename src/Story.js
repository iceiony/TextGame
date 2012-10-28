"use strict";
/**
 * Contains the game story as a JSON object
 */
var Story = {
    Title : "Aristocratii",
    "initial": {
        atRender: ["initiateFirstScene", "typeWriterDisplay"],
        content: "Gazda a plecat in bucatarie, sa faca o ceasca de ceai.        <br/>Ashteptand admiri decoratiunile in stil rustic .      " +
                 "<br/>Mobilier de stejar, frumos sculptate, si e adevart, iti trece prin cap:       <p>'Asta e casa unor aristocrati adevarati'</p>",
        transitions: {
            "un_copil": ["","*"]
        }
    },
    "un_copil":{
        content:"Dintr-o data obervi un copil stand in capatul celalt al camerei. Ai fost prea absorbit de imprejurari ca sa il observi cand a ajuns acolo.                    " +
                "<br/>Are cam 10 ani , si se uita timid la tine. Te intrebi in sine: 'Oare ce sa fac ?'",
        transitions: {
             "spune_buna": ["buna","spunei buna", "spune buna"],
             "descrie": ["privestel","uitate la el","holbeazate la el"],
             "tace": ["","nu face nimic"]
        }
    },
    "tace": {
        content: "Copilul se uita in pamant, si se leagana de pe un picior pe altul.      " +
            "<br/>Dupa cateva secude se uita spre tine si te intreaba : 'Dar tu...      Cine eshti ? "    ,
        transitions:{
             "numele_meu":"*"
        }
    },
    "descrie": {
        content:"E imbracat intr-o uniforma de marinar."
    },
    "spune_buna":{
        content:"Ii spun 'Buna'. <br/>Copilul se uita brusc spre mine.      'Buna si tie'     <br/>Si o ia la fuga"
    },
    numele_meu : {
        content: "Imi raspunde 'OOOO Grozav nume'"
    }
};

//"use strict";
///**
// * Contains the game story as a JSON object
// */
//var Story = {
//    "initial": {//TODO make scene dark with white text and blink into dark read back ground as if heart beating
//        defaultRender: ["initiateFirstScene", "typeWriterDisplay"],
//        content: "'What... where am I.. who am I ? I must focus, focus on remembering , my name... what is it ?'</br>" +
//             "'Yes! I remember now I'm...'",
//        transitions: {
//            "blame": ["I am *", "My name is *", "*"]
//        }
//    },
//    "blame": {
//        content: "And so I've reached the point of my demise. While the cold and darkness are slowly draining my life, shivers and despair drift through my chest. I cannot help but wonder what I have done so wrong. " +
//             "What is it that I cherish most, and the reason for this ill fate? Was it my thirst for knowledge, love, or was it God; has has forsaken me? What or who would I blame ?",
//        transitions: {
//            "blame_knowledge": "knowledge",
//            "blame_love": "love",
//            "blame_god": "god",
//            "blame_none": ["blame_none", "blame_none", "*"]
//        }
//    },
//    "blame_knowledge": {
//        content: "To learn, to know, to bring use to this short existence. What meaning have I found in life other than helping humanity and its future through discovery and invention. Knowledge, as I see, is the only way to achieve such greatness. ",
//        transitions: {
//            "flash_back": ""
//        }
//    },
//    "blame_love": {
//        content: "Love Of course, it has to be it. What else would shape ones will more than fallowing hearts' desires. It must have been you, my love...the one desire above all other.",
//        transitions: {
//            "flash_back": ""
//        }
//
//    },
//    "blame_god": {
//        content: "Born from His mercy, we live by His good will. What creature would defy its destiny, our Lords' will? Father, I pray that I did not anger you and played my purpose well.",
//        transitions: {
//            "flash_back": ""
//        }
//    },
//    "blame_none": {
//        content: "I must think too highly of myself to believe that there is any importance to the world in my life and death. We are all just insignificant specs in this immense universe. " +
//            "Insignificant and with a pointless existence, we must at least seek happiness while we live.<br/> <br/>" +
//            "Some of us require a better reason for living than just to be.",
//        transitions: {
//            "flash_back": ""
//        }
//    },
//    "flash_back": {//TODO: make scene worm white as if remembering a childhood memory, and stop the beating like heart
//        content: "Sitting by the window, I feel how the summer sun is slowly burning into the my skin. But I barely notice I am gazing into an open book." +
//            "<br/>Its pages are bright, as if staring into a small sun. Yet even brighter is her face, sitting across from me , smiling back." +
//            "As if I wake up from this memory, it feels pointless yet it carries the essence of what I hold dear. " +
//            "<br/>A whisper slip from my lips:" +
//            "<br/>'Oh my friend, my only one, I was but a simple child without a care in the world. What would I know at the time...'" +
//            "<br/>If I could start again, I would chose differently, a new path, a right one. And I remember that precise moment, when without warning, destiny started to unfold ….",
//        transitions:{
//            "exam_scene": ""
//        }
//    },
//    "exam_scene": {//TODO: make scene white
//        content: "As I'm working through the question of my admission exams, I'm desperately trying to keep my emotions under control."+
//            "<br/>I know it's not a test in the true sense. Its only purpose is to find out how I'd fit in. But even so , I do not want to give a wrong impression of who I am."
//    }
//};