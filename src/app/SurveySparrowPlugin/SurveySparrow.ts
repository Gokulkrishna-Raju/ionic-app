import { registerPlugin } from "@capacitor/core";

export interface SurveySparrowPlugin {
    loadFullScreenSurvey(opts: {domain: string, token: string}): Promise<void>;
}

const SurveySparrowPlugin = registerPlugin<SurveySparrowPlugin>('SurveySparrowPlugin');

export default SurveySparrowPlugin;
