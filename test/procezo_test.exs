defmodule ProcezoTest do
  use ExUnit.Case
  doctest Procezo

  test "basic process" do

    teksto = "Ekde la mezepoko, Luksemburgio - kiu tiam okcidente enhavas franclingvan regionon, kie estas parolataj la valonaj dialektoj, kaj oriente germanlingvan regionon, kie estas parolataj la mozelfrankaj dialektoj - elektas la francan, kiel administracian lingvon. Kiam ĝi okupas ĝian teritorion, en la 17-a jarcento kaj dum la revolucio, en 1795 - kreante la portempan distrikton de Arbaroj - Francio trudas sian lingvon en la publika vivo. Post la malvenko de Napoleono en Vaterlo, la kongreso de Vieno decidas la kreon de la Granda Duklando, ligita per persona unio al la reĝo de Nederlando, sed aliĝanta al la Germana konfederacio, tiama malstrikta unio de germanlingvaj reĝlandoj, princlandoj kaj suverenaj ŝtatoj.

  Sekve de la Belga revolucio, la traktato de Londono (1839) limigas la Grandan Duklandon, de tiam sendependan, al la germanlingvaj regionoj. La okcidenta parto, ĉefe franclingva, iĝas la samnoma Belga provinco de Luksemburgio. Dum la Granda Duklando aliĝas al la Germana dogana unio (Zollverein) la elitoj trudas la konservon de la franca, kiel lingvo administracia, justica kaj politika. En 1843 ĝi estas enmetita en la instruado ekde la primara, tuj post la germana. Ĉiutaga lingvo kaj formo de la mozelfranka, la luksemburga estos nur enmetita en 1912, po unu horo de konversacio semajne.

  En majo 1940 la Granda Duklando estas invadita de la nazia Germanio, kaj aneksita, la franca estas malpermesita. Unu jaron poste, la okupanto estas devigita nuligi la impostan popolkalkuladon, ĉar la homoj trifoje respondis \"Luksemburga\" al la demandoj pri etno, lingvo kaj nacieco. Tiu epizodo de pasiva rezistado estas parto de la nacia romano, kun la grandaj strikoj de 1942 kontraŭ la rekrutigo de la junuloj en la Germana armeo.

  Post la milito, la uzo de la franca kiel skriblingvo kaj tiu de la luksemburga kiel parollingvo iĝas marko de identeco. Kvankam restanta la unua lingvo instruata en lernejado, la germana malprogresas en la publika sfero. La uzo de la lingvo de Moliero plivastiĝas pro ĝia uzo fare de la multaj enmigrintoj venintaj de latinidaj landoj. En situacio de rapida kresko de la nombro de fremduloj kaj mobilizado de naciistaj movadoj pri lingvaj demandoj, ekzemple la asocio Actioun Lëtzebuergesh, la leĝo de la 24-a de februaro 1984 efektivigas la luksemburgan, kiel \"nacian lingvon\" kaj devigas la administracion respondi en la tri lingvoj uzataj, laŭ la elekto de la demandinto. En oktobro 2008, nova leĝo postulas sukceson en ekzameno pri scipovo de la luksemburga por akiri la Luksemburgian civitanecon. La antaŭeniĝo de ĉi lasta ankaŭ plifortiĝas pro la leĝo de la 20-a de julio 2018."

    efikoj = "banjo"

    Procezo.procezu(teksto)

    #assert Procezo.procezu(teksto) == efikoj
    assert true == false

  end

end
