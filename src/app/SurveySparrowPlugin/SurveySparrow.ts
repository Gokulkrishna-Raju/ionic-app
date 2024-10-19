import { registerPlugin } from "@capacitor/core";

export interface SurveySparrowPlugin {
    
    loadEmbeddedSurvey(opts: { 
        domain: string; 
        token: string; 
        params?: { [key: string]: string };
        sparrowLang?: string;
    }): Promise<void>;

    loadFullScreenSurvey(opts: { 
        domain: string; 
        token: string; 
        params?: { [key: string]: string };
        sparrowLang?: string;
    }): Promise<void>;

    loadFullScreenSurveyWithValidation(opts: { 
        domain: string; 
        token: string; 
        params?: { [key: string]: string };
        sparrowLang?: string;
    }): Promise<void>;
    
}

const SurveySparrowPlugin = registerPlugin<SurveySparrowPlugin>('SurveySparrowPlugin');

export default SurveySparrowPlugin;
