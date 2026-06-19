using {YY1_WORKFORCE_CDS as wf} from './external/YY1_WORKFORCE_CDS';

service WorkforceServices {
    entity Workforces as projection on wf.YY1_Workforce;
}
