//Mutable Subjects (version for corporeal and virtual marimbas)
//
//
//
//------INSTRUCTIONS for Evaluating File-----------
//Before you can run this program you must alter the following line.
//Replace this line with the complete path to the directory "MutableObjects/SAMPS" (you can do this by copying the file path from finder or another file manager)

~samplepath = "/home/tuckerj/Documents/Supercollider/MutableObjects/SAMPS";

//Once you have changed the line above, highlight the following line and press shift+enter

~marstr = Array.new; ~folder = PathName.new(~samplepath); ~folder.entries.do({ arg path; ~marstr = ~marstr.add(Buffer.read(s, path.fullPath));});

//Now, in the "Language" drop-down menu click "evaluate file"
//the piece will begin!!
//
//
//
///////////////////////////////////////////////////////////////////////////////DO NOT MODIFY
//marimba synth*****marimba synth

SynthDef.new(\virtmarimba, {
	arg amp=1, out=0, pan=0, pitchy=1, t60=1.3, buf=5;
	var sig;
	sig = PlayBuf.ar(2, buf-45);
	sig = sig * amp;
	DetectSilence.ar(sig, 0.001, 0.5, doneAction:2);
	Out.ar(out, sig);
}).add;

//Synth.new(\virtmarimba, [\buf, 46]);
//SynthDef(\virtmarimba, {
//	|freq = 440, t60=1.3, pitchy=1, amp=0.25, pan = 0|
//	var sig, exciter;
//	exciter = WhiteNoise.ar(0.2) * EnvGen.ar(Env.perc(0.001, 0.005)) * 0.2;
//	sig = DynKlank.ar(
//		`[
//			[1, 2, 3, 4, 5, 6],   // freqs
//			[1.2, 0.244, 0.691, 0.2491, 0.394, 0.23], // amplitudes
//			[1, 0.205, 0.5, 0.196, 0.239, 0.1, 0.05]*t60
//		],
//		exciter,
//		freqscale: freq);
//	DetectSilence.ar(sig, 0.001, 0.5, doneAction:2);
//	Out.ar(0, Pan2.ar(sig, pan, amp));
//}).add;

//structure routines*****structure routines
~structure = Routine.new({
	t = case
	{ x.size == 3 }   { (((y.at(0)+12)-(x+12))*(-1))%12++(((y.at(1)+12)-(x+12))*(-1))%12++(((y.at(2)+12)-(x+12))*(-1))%12 }
	{ x.size == 4 }   { (((y.at(0)+12)-(x+12))*(-1))%12++(((y.at(1)+12)-(x+12))*(-1))%12++(((y.at(2)+12)-(x+12))*(-1))%12++(((y.at(3)+12)-(x+12))*(-1))%12; }
	{ x.size == 5 }   { (((y.at(0)+12)-(x+12))*(-1))%12++(((y.at(1)+12)-(x+12))*(-1))%12++(((y.at(2)+12)-(x+12))*(-1))%12++(((y.at(3)+12)-(x+12))*(-1))%12++
		                (((y.at(4)+12)-(x+12))*(-1))%12; }
	{ x.size == 6 }   { (((y.at(0)+12)-(x+12))*(-1))%12++(((y.at(1)+12)-(x+12))*(-1))%12++(((y.at(2)+12)-(x+12))*(-1))%12++(((y.at(3)+12)-(x+12))*(-1))%12++
		                (((y.at(4)+12)-(x+12))*(-1))%12++(((y.at(5)+12)-(x+12))*(-1))%12; }
	{ x.size == 7 }   { (((y.at(0)+12)-(x+12))*(-1))%12++(((y.at(1)+12)-(x+12))*(-1))%12++(((y.at(2)+12)-(x+12))*(-1))%12++(((y.at(3)+12)-(x+12))*(-1))%12++
		                (((y.at(4)+12)-(x+12))*(-1))%12++(((y.at(5)+12)-(x+12))*(-1))%12++(((y.at(6)+12)-(x+12))*(-1))%12; }
	{ x.size == 8 }   { (((y.at(0)+12)-(x+12))*(-1))%12++(((y.at(1)+12)-(x+12))*(-1))%12++(((y.at(2)+12)-(x+12))*(-1))%12++(((y.at(2)+12)-(x+12))*(-1))%12++
		                (((y.at(4)+12)-(x+12))*(-1))%12++(((y.at(5)+12)-(x+12))*(-1))%12++(((y.at(6)+12)-(x+12))*(-1))%12++(((y.at(7)+12)-(x+12))*(-1))%12; }
	{ x.size == 9 }   { (((y.at(0)+12)-(x+12))*(-1))%12++(((y.at(1)+12)-(x+12))*(-1))%12++(((y.at(2)+12)-(x+12))*(-1))%12++(((y.at(3)+12)-(x+12))*(-1))%12++
		                (((y.at(4)+12)-(x+12))*(-1))%12++(((y.at(5)+12)-(x+12))*(-1))%12++(((y.at(6)+12)-(x+12))*(-1))%12++(((y.at(7)+12)-(x+12))*(-1))%12++
	                	(((y.at(8)+12)-(x+12))*(-1))%12; };
	~tvec = [(t.occurrencesOf(1)+t.occurrencesOf(11)), (t.occurrencesOf(2)+t.occurrencesOf(10)),
		(t.occurrencesOf(3)+t.occurrencesOf(9)), (t.occurrencesOf(4)+t.occurrencesOf(8)), (t.occurrencesOf(5)+t.occurrencesOf(7)),
		(t.occurrencesOf(6))];
	~tscor = (([1,2,3,4,5,6] * ~tvec).sum / ~tvec.sum);
	~tlist = t.replace(7, 5).replace(8, 4).replace(9, 3).replace(10, 2).replace(11, 1);
	~tmat = Array2D.fromArray(x.size,y.size,~tlist);
	(x.size > 3).if ({~gate3 = ~secD}, {~gate3 = ~fin}); (x.size > 4).if ({~gate4 = ~secE}, {~gate4 = ~fin});
	(x.size > 5).if ({~gate5 = ~secF}, {~gate5 = ~fin}); (x.size > 6).if ({~gate6 = ~secG}, {~gate6 = ~fin});
	(x.size > 7).if ({~gate7 = ~secH}, {~gate7 = ~fin}); (x.size > 8).if ({~gate8 = ~secI}, {~gate8 = ~fin});
	~delts = case
	{ x.size == 3 }   { [(~tmat.rowAt(0);).at(0)]++[(~tmat.rowAt(1);).at(1)]++[(~tmat.rowAt(2);).at(2)] }
	{ x.size == 4 }   { [(~tmat.rowAt(0);).at(0)]++[(~tmat.rowAt(1);).at(1)]++[(~tmat.rowAt(2);).at(2)]++[(~tmat.rowAt(3);).at(3)] }
	{ x.size == 5 }   { [(~tmat.rowAt(0);).at(0)]++[(~tmat.rowAt(1);).at(1)]++[(~tmat.rowAt(2);).at(2)]++[(~tmat.rowAt(3);).at(3)]++
		                [(~tmat.rowAt(4);).at(4)] }
	{ x.size == 6 }   { [(~tmat.rowAt(0);).at(0)]++[(~tmat.rowAt(1);).at(1)]++[(~tmat.rowAt(2);).at(2)]++[(~tmat.rowAt(3);).at(3)]++
		                [(~tmat.rowAt(4);).at(4)]++[(~tmat.rowAt(5);).at(5)] }
	{ x.size == 7 }   { [(~tmat.rowAt(0);).at(0)]++[(~tmat.rowAt(1);).at(1)]++[(~tmat.rowAt(2);).at(2)]++[(~tmat.rowAt(3);).at(3)]++
		                [(~tmat.rowAt(4);).at(4)]++[(~tmat.rowAt(5);).at(5)]++[(~tmat.rowAt(6);).at(6)] }
	{ x.size == 8 }   { [(~tmat.rowAt(0);).at(0)]++[(~tmat.rowAt(1);).at(1)]++[(~tmat.rowAt(2);).at(2)]++[(~tmat.rowAt(3);).at(3)]++
		                [(~tmat.rowAt(4);).at(4)]++[(~tmat.rowAt(5);).at(5)]++[(~tmat.rowAt(6);).at(6)]++[(~tmat.rowAt(7);).at(7)] }
	{ x.size == 9 }   { [(~tmat.rowAt(0);).at(0)]++[(~tmat.rowAt(1);).at(1)]++[(~tmat.rowAt(2);).at(2)]++[(~tmat.rowAt(3);).at(3)]++
		                [(~tmat.rowAt(4);).at(4)]++[(~tmat.rowAt(5);).at(5)]++[(~tmat.rowAt(6);).at(6)]++[(~tmat.rowAt(7);).at(7)]++
		                [(~tmat.rowAt(8);).at(8)] };
	~tmatf = Array2D.fromArray(x.size,y.size,t);
	~deltsf = case
	{ x.size == 3 }   { [(~tmatf.rowAt(0);).at(0)]++[(~tmatf.rowAt(1);).at(1)]++[(~tmatf.rowAt(2);).at(2)] }
	{ x.size == 4 }   { [(~tmatf.rowAt(0);).at(0)]++[(~tmatf.rowAt(1);).at(1)]++[(~tmatf.rowAt(2);).at(2)]++[(~tmatf.rowAt(3);).at(3)] }
	{ x.size == 5 }   { [(~tmatf.rowAt(0);).at(0)]++[(~tmatf.rowAt(1);).at(1)]++[(~tmatf.rowAt(2);).at(2)]++[(~tmatf.rowAt(3);).at(3)]++
		                [(~tmatf.rowAt(4);).at(4)] }
	{ x.size == 6 }   { [(~tmatf.rowAt(0);).at(0)]++[(~tmatf.rowAt(1);).at(1)]++[(~tmatf.rowAt(2);).at(2)]++[(~tmatf.rowAt(3);).at(3)]++
		                [(~tmatf.rowAt(4);).at(4)]++[(~tmatf.rowAt(5);).at(5)] }
	{ x.size == 7 }   { [(~tmatf.rowAt(0);).at(0)]++[(~tmatf.rowAt(1);).at(1)]++[(~tmatf.rowAt(2);).at(2)]++[(~tmatf.rowAt(3);).at(3)]++
		                [(~tmatf.rowAt(4);).at(4)]++[(~tmatf.rowAt(5);).at(5)]++[(~tmatf.rowAt(6);).at(6)] }
	{ x.size == 8 }   { [(~tmatf.rowAt(0);).at(0)]++[(~tmatf.rowAt(1);).at(1)]++[(~tmatf.rowAt(2);).at(2)]++[(~tmatf.rowAt(3);).at(3)]++
		                [(~tmatf.rowAt(4);).at(4)]++[(~tmatf.rowAt(5);).at(5)]++[(~tmatf.rowAt(6);).at(6)]++[(~tmatf.rowAt(7);).at(7)] }
	{ x.size == 9 }   { [(~tmatf.rowAt(0);).at(0)]++[(~tmatf.rowAt(1);).at(1)]++[(~tmatf.rowAt(2);).at(2)]++[(~tmatf.rowAt(3);).at(3)]++
		                [(~tmatf.rowAt(4);).at(4)]++[(~tmatf.rowAt(5);).at(5)]++[(~tmatf.rowAt(6);).at(6)]++[(~tmatf.rowAt(7);).at(7)]++
		                [(~tmatf.rowAt(8);).at(8)] };
});


~tim = Routine.new({
	~len = StaticText(w, Rect(650, 10, 60, 20)).font = ~fone;
	~min = (((~delts.at(0)+1 * d)+
		(~delts.at(1)+1 * d)+
		(~delts.at(2)+1 * d)+
		((x.size > 3).if ({(~delts.at(3)+1 * d)}, {0}))+
		((x.size > 4).if ({(~delts.at(3)+1 * d)}, {0}))+
		((x.size > 5).if ({(~delts.at(3)+1 * d)}, {0}))+
		((x.size > 6).if ({(~delts.at(3)+1 * d)}, {0}))+
		((x.size > 7).if ({(~delts.at(3)+1 * d)}, {0}))+
		((x.size > 8).if ({(~delts.at(3)+1 * d)}, {0})))/60).asInteger;
	~sec = ((~delts.at(0)+1 * d)+
		(~delts.at(1)+1 * d)+
		(~delts.at(2)+1 * d)+
		((x.size > 3).if ({(~delts.at(3)+1 * d)}, {0}))+
		((x.size > 4).if ({(~delts.at(3)+1 * d)}, {0}))+
		((x.size > 5).if ({(~delts.at(3)+1 * d)}, {0}))+
		((x.size > 6).if ({(~delts.at(3)+1 * d)}, {0}))+
		((x.size > 7).if ({(~delts.at(3)+1 * d)}, {0}))+
		((x.size > 8).if ({(~delts.at(3)+1 * d)}, {0})))-(~min*60);
	~len.string = ~min.asString++":"++~sec.asString;
	~cA = CheckBox(w, Rect(650, 30, 60, 20), "A "++(~delts.at(0)+1 * d).asString++"s" ).font = ~fone;
	~cB = CheckBox(w, Rect(650, 60, 60, 20), "B "++(~delts.at(1)+1 * d).asString++"s" ).font = ~fone;
	~cC = CheckBox(w, Rect(650, 90, 60, 20), "C "++(~delts.at(2)+1 * d).asString++"s" ).font = ~fone;
	~cD = CheckBox.new(w, Rect(650, 120, 60, 20), "").font = ~fone; (x.size > 3).if ({~cD.string = "D "++(~delts.at(3)+1 * d).asString++"s"}, {~cD.remove});
    ~cE = CheckBox.new(w, Rect(650, 150, 60, 20), "").font = ~fone; (x.size > 4).if ({~cE.string = "E "++(~delts.at(4)+1 * d).asString++"s"}, {~cE.remove});
    ~cF = CheckBox.new(w, Rect(650, 180, 60, 20), "").font = ~fone; (x.size > 5).if ({~cF.string = "F "++(~delts.at(5)+1 * d).asString++"s"}, {~cF.remove});
    ~cG = CheckBox.new(w, Rect(650, 210, 60, 20), "").font = ~fone; (x.size > 6).if ({~cG.string = "G "++(~delts.at(6)+1 * d).asString++"s"}, {~cG.remove});
    ~cH = CheckBox.new(w, Rect(650, 240, 60, 20), "").font = ~fone; (x.size > 7).if ({~cH.string = "H "++(~delts.at(7)+1 * d).asString++"s"}, {~cH.remove});
    ~cI = CheckBox.new(w, Rect(650, 270, 60, 20), "").font = ~fone; (x.size > 8).if ({~cI.string = "I "++(~delts.at(8)+1 * d).asString++"s"}, {~cI.remove});
	(x.size > 3).if ({~tgate3 = 0}, {~tgate3 = "ding"}); (x.size > 4).if ({~tgate4 = 0}, {~tgate4 = "ding"});
	(x.size > 5).if ({~tgate5 = 0}, {~tgate5 = "ding"}); (x.size > 6).if ({~tgate6 = 0}, {~tgate6 = "ding"});
	(x.size > 7).if ({~tgate7 = 0}, {~tgate7 = "ding"}); (x.size > 8).if ({~tgate8 = 0}, {~tgate8 = "ding"});
	~cA.value = true;
	((~delts.at(0)+1 * d) - 3).yield; 0.2.yield; ~cB.value = true; 0.2.yield; ~cB.value = false; 0.2.yield;
	~cB.value = true; 0.2.yield; ~cB.value = false; 0.2.yield; ~cB.value = true; 0.2.yield; ~cB.value = false; 0.2.yield; ~cB.value = true; 0.2.yield;
	~cB.value = false; 0.2.yield; ~cB.value = true; 0.2.yield; ~cB.value = false; 0.2.yield; ~cB.value = true; 0.2.yield; ~cB.value = false; 0.2.yield;
	~cB.value = true; 0.2.yield; ~cB.value = false; 0.2.yield; ~cB.value = true; ~cA.value = false;
	((~delts.at(1)+1 * d)-3).yield; 0.2.yield; ~cC.value = true; 0.2.yield; ~cC.value = false; 0.2.yield;
	~cC.value = true; 0.2.yield; ~cC.value = false; 0.2.yield; ~cC.value = true; 0.2.yield; ~cC.value = false; 0.2.yield; ~cC.value = true; 0.2.yield;
	~cC.value = false; 0.2.yield; ~cC.value = true; 0.2.yield; ~cC.value = false; 0.2.yield; ~cC.value = true; 0.2.yield; ~cC.value = false; 0.2.yield;
	~cC.value = true; 0.2.yield; ~cC.value = false; 0.2.yield; ~cC.value = true; ~cB.value = false;
	((~delts.at(2)+1 * d)-3).yield; 0.2.yield; ~cD.value = true; 0.2.yield; ~cD.value = false; 0.2.yield;
	~cD.value = true; 0.2.yield; ~cD.value = false; 0.2.yield; ~cD.value = true; 0.2.yield; ~cD.value = false; 0.2.yield; ~cD.value = true; 0.2.yield;
	~cD.value = false; 0.2.yield; ~cD.value = true; 0.2.yield; ~cD.value = false; 0.2.yield; ~cD.value = true; 0.2.yield; ~cD.value = false; 0.2.yield;
	~cD.value = true; 0.2.yield; ~cD.value = false; 0.2.yield; ~cD.value = true; ~cC.value = false;
	(~tgate3).yield;
	((~delts.at(3)+1 * d)-3).yield; 0.2.yield; ~cE.value = true; 0.2.yield; ~cE.value = false; 0.2.yield;
	~cE.value = true; 0.2.yield; ~cE.value = false; 0.2.yield; ~cE.value = true; 0.2.yield; ~cE.value = false; 0.2.yield; ~cE.value = true; 0.2.yield;
	~cE.value = false; 0.2.yield; ~cE.value = true; 0.2.yield; ~cE.value = false; 0.2.yield; ~cE.value = true; 0.2.yield; ~cE.value = false; 0.2.yield;
	~cE.value = true; 0.2.yield; ~cE.value = false; 0.2.yield; ~cE.value = true; ~cD.value = false;
	(~tgate4).yield;
	((~delts.at(4)+1 * d)-3).yield; 0.2.yield; ~cF.value = true; 0.2.yield; ~cF.value = false; 0.2.yield;
	~cF.value = true; 0.2.yield; ~cF.value = false; 0.2.yield; ~cF.value = true; 0.2.yield; ~cF.value = false; 0.2.yield; ~cF.value = true; 0.2.yield;
	~cF.value = false; 0.2.yield; ~cF.value = true; 0.2.yield; ~cF.value = false; 0.2.yield; ~cF.value = true; 0.2.yield; ~cF.value = false; 0.2.yield;
	~cF.value = true; 0.2.yield; ~cF.value = false; 0.2.yield; ~cF.value = true; ~cE.value = false;
	(~tgate5).yield;
	((~delts.at(5)+1 * d)-3).yield; 0.2.yield; ~cG.value = true; 0.2.yield; ~cG.value = false; 0.2.yield;
	~cG.value = true; 0.2.yield; ~cG.value = false; 0.2.yield; ~cG.value = true; 0.2.yield; ~cG.value = false; 0.2.yield; ~cG.value = true; 0.2.yield;
	~cG.value = false; 0.2.yield; ~cG.value = true; 0.2.yield; ~cG.value = false; 0.2.yield; ~cG.value = true; 0.2.yield; ~cG.value = false; 0.2.yield;
	~cG.value = true; 0.2.yield; ~cG.value = false; 0.2.yield; ~cG.value = true; ~cF.value = false;
	(~tgate6).yield;
	((~delts.at(6)+1 * d)-3).yield; 0.2.yield; ~cH.value = true; 0.2.yield; ~cH.value = false; 0.2.yield;
	~cH.value = true; 0.2.yield; ~cH.value = false; 0.2.yield; ~cH.value = true; 0.2.yield; ~cH.value = false; 0.2.yield; ~cH.value = true; 0.2.yield;
	~cH.value = false; 0.2.yield; ~cH.value = true; 0.2.yield; ~cH.value = false; 0.2.yield; ~cH.value = true; 0.2.yield; ~cH.value = false; 0.2.yield;
	~cH.value = true; 0.2.yield; ~cH.value = false; 0.2.yield; ~cH.value = true; ~cG.value = false;
	(~tgate7).yield;
	((~delts.at(7)+1 * d)-3).yield; 0.2.yield; ~cI.value = true; 0.2.yield; ~cI.value = false; 0.2.yield;
	~cI.value = true; 0.2.yield; ~cI.value = false; 0.2.yield; ~cI.value = true; 0.2.yield; ~cI.value = false; 0.2.yield; ~cI.value = true; 0.2.yield;
	~cI.value = false; 0.2.yield; ~cI.value = true; 0.2.yield; ~cI.value = false; 0.2.yield; ~cI.value = true; 0.2.yield; ~cI.value = false; 0.2.yield;
	~cI.value = true; 0.2.yield; ~cI.value = false; 0.2.yield; ~cI.value = true; ~cH.value = false;
	(~tgate8).yield;
	((~delts.at(8)+1 * d)).yield; ~cH.value = false;
	"ding".post.yield;
});



~fin = Routine.new({
	~toptex.string = "the END";
	s.freeAll; s.sendMsg(\quit); 3.yield; w.close;
});

~secA = Routine.new({
	~toptex.string = "Section A"; AppClock.play(~yA);
	~dyn = Slider(w, Rect(55, 200, 200, 30)).acceptsMouse = false;
	~den = Slider(w, Rect(305, 200, 200, 30)).acceptsMouse = false;
	~dynlab1 = StaticText(w, Rect(60, 160, 195, 30)).string = "p"; ~dynlab1.font = ~fthre; ~dynlab1.align = \left;
	~dynlab2 = StaticText(w, Rect(60, 160, 195, 30)).string = "m"; ~dynlab2.font = ~fthre; ~dynlab2.align = \center;
	~dynlab3 = StaticText(w, Rect(60, 160, 195, 30)).string = "f"; ~dynlab3.font = ~fthre; ~dynlab3.align = \right;
	~denlab1 = StaticText(w, Rect(310, 160, 195, 30)).string = "5"; ~denlab1.font = ~fthre; ~denlab1.align = \left;
	~denlab2 = StaticText(w, Rect(310, 160, 195, 30)).string = "1"; ~denlab2.font = ~fthre; ~denlab2.align = \center;
	~denlab3 = StaticText(w, Rect(310, 160, 195, 30)).string = "1/5"; ~denlab3.font = ~fthre; ~denlab3.align = \right;
	~xvec = [(~tmat.rowAt(0).occurrencesOf(1) + ~tmat.rowAt(0).occurrencesOf(11)), (~tmat.rowAt(0).occurrencesOf(2) + ~tmat.rowAt(0).occurrencesOf(10)),
		(~tmat.rowAt(0).occurrencesOf(3) + ~tmat.rowAt(0).occurrencesOf(9)), (~tmat.rowAt(0).occurrencesOf(4) + ~tmat.rowAt(0).occurrencesOf(8)),
		(~tmat.rowAt(0).occurrencesOf(5) + ~tmat.rowAt(0).occurrencesOf(7)), (~tmat.rowAt(0).occurrencesOf(6))];
	~xscor = (~tscor - (([1,2,3,4,5,6] * ~xvec).sum / ~xvec.sum));
	~xdb = ((~xscor+1.75)/3.5);
	~xtime = (((~tmat.rowAt(0)+0.1).mean)/8);
	~den.value_(~xtime);
	~dyn.value_(~xdb);
	((x++((y+~deltsf.at(0))%12)).asSet.includes(0)).if ({~bC.valueAction = 1}, {~bC.valueAction = 3});
	((x++((y+~deltsf.at(0))%12)).asSet.includes(1)).if ({~bDb.valueAction = 1}, {~bDb.valueAction = 3});
	((x++((y+~deltsf.at(0))%12)).asSet.includes(2)).if ({~bD.valueAction = 1}, {~bD.valueAction = 3});
	((x++((y+~deltsf.at(0))%12)).asSet.includes(3)).if ({~bEb.valueAction = 1}, {~bEb.valueAction = 3});
	((x++((y+~deltsf.at(0))%12)).asSet.includes(4)).if ({~bE.valueAction = 1}, {~bE.valueAction = 3});
	((x++((y+~deltsf.at(0))%12)).asSet.includes(5)).if ({~bF.valueAction = 1}, {~bF.valueAction = 3});
	((x++((y+~deltsf.at(0))%12)).asSet.includes(6)).if ({~bGb.valueAction = 1}, {~bGb.valueAction = 3});
	((x++((y+~deltsf.at(0))%12)).asSet.includes(7)).if ({~bG.valueAction = 1}, {~bG.valueAction = 3});
	((x++((y+~deltsf.at(0))%12)).asSet.includes(8)).if ({~bAb.valueAction = 1}, {~bAb.valueAction = 3});
	((x++((y+~deltsf.at(0))%12)).asSet.includes(9)).if ({~bA.valueAction = 1}, {~bA.valueAction = 3});
	((x++((y+~deltsf.at(0))%12)).asSet.includes(10)).if ({~bBb.valueAction = 1}, {~bBb.valueAction = 3});
	((x++((y+~deltsf.at(0))%12)).asSet.includes(11)).if ({~bB.valueAction = 1}, {~bB.valueAction = 3});
	(~delts.at(0)+1 * d).yield;
	AppClock.play(~secB);
});

~secB = Routine.new({
	~toptex.string = "Section B"; AppClock.play(~yB);
	~xvec = [(~tmat.rowAt(1).occurrencesOf(1) + ~tmat.rowAt(1).occurrencesOf(11)), (~tmat.rowAt(1).occurrencesOf(2) + ~tmat.rowAt(1).occurrencesOf(10)),
		(~tmat.rowAt(1).occurrencesOf(3) + ~tmat.rowAt(1).occurrencesOf(9)), (~tmat.rowAt(1).occurrencesOf(4) + ~tmat.rowAt(1).occurrencesOf(8)),
		(~tmat.rowAt(1).occurrencesOf(5) + ~tmat.rowAt(1).occurrencesOf(7)), (~tmat.rowAt(1).occurrencesOf(6))];
	~xscor = (~tscor - (([1,2,3,4,5,6] * ~xvec).sum / ~xvec.sum));
	~xdb = ((~xscor+1.75)/3.5);
	~xtime = (((~tmat.rowAt(1)+0.1).mean)/8);
	~den.value_(~xtime);
	~dyn.value_(~xdb);
	((x++((y+~deltsf.at(1))%12)).asSet.includes(0)).if ({~bC.valueAction = 1}, {~bC.valueAction = 3});
	((x++((y+~deltsf.at(1))%12)).asSet.includes(1)).if ({~bDb.valueAction = 1}, {~bDb.valueAction = 3});
	((x++((y+~deltsf.at(1))%12)).asSet.includes(2)).if ({~bD.valueAction = 1}, {~bD.valueAction = 3});
	((x++((y+~deltsf.at(1))%12)).asSet.includes(3)).if ({~bEb.valueAction = 1}, {~bEb.valueAction = 3});
	((x++((y+~deltsf.at(1))%12)).asSet.includes(4)).if ({~bE.valueAction = 1}, {~bE.valueAction = 3});
	((x++((y+~deltsf.at(1))%12)).asSet.includes(5)).if ({~bF.valueAction = 1}, {~bF.valueAction = 3});
	((x++((y+~deltsf.at(1))%12)).asSet.includes(6)).if ({~bGb.valueAction = 1}, {~bGb.valueAction = 3});
	((x++((y+~deltsf.at(1))%12)).asSet.includes(7)).if ({~bG.valueAction = 1}, {~bG.valueAction = 3});
	((x++((y+~deltsf.at(1))%12)).asSet.includes(8)).if ({~bAb.valueAction = 1}, {~bAb.valueAction = 3});
	((x++((y+~deltsf.at(1))%12)).asSet.includes(9)).if ({~bA.valueAction = 1}, {~bA.valueAction = 3});
	((x++((y+~deltsf.at(1))%12)).asSet.includes(10)).if ({~bBb.valueAction = 1}, {~bBb.valueAction = 3});
	((x++((y+~deltsf.at(1))%12)).asSet.includes(11)).if ({~bB.valueAction = 1}, {~bB.valueAction = 3});

	(~delts.at(1)+1 * d).yield;
	AppClock.play(~secC);
});

~secC = Routine.new({
	~toptex.string = "Section C"; AppClock.play(~yC);
	~xvec = [(~tmat.rowAt(2).occurrencesOf(1) + ~tmat.rowAt(2).occurrencesOf(11)), (~tmat.rowAt(2).occurrencesOf(2) + ~tmat.rowAt(2).occurrencesOf(10)),
		(~tmat.rowAt(2).occurrencesOf(3) + ~tmat.rowAt(2).occurrencesOf(9)), (~tmat.rowAt(2).occurrencesOf(4) + ~tmat.rowAt(2).occurrencesOf(8)),
		(~tmat.rowAt(2).occurrencesOf(5) + ~tmat.rowAt(2).occurrencesOf(7)), (~tmat.rowAt(2).occurrencesOf(6))];
	~xscor = (~tscor - (([1,2,3,4,5,6] * ~xvec).sum / ~xvec.sum));
	~xdb = ((~xscor+1.75)/3.5);
	~xtime = (((~tmat.rowAt(2)+0.1).mean)/8);
	~den.value_(~xtime);
	~dyn.value_(~xdb);
	((x++((y+~deltsf.at(2))%12)).asSet.includes(0)).if ({~bC.valueAction = 1}, {~bC.valueAction = 3});
	((x++((y+~deltsf.at(2))%12)).asSet.includes(1)).if ({~bDb.valueAction = 1}, {~bDb.valueAction = 3});
	((x++((y+~deltsf.at(2))%12)).asSet.includes(2)).if ({~bD.valueAction = 1}, {~bD.valueAction = 3});
	((x++((y+~deltsf.at(2))%12)).asSet.includes(3)).if ({~bEb.valueAction = 1}, {~bEb.valueAction = 3});
	((x++((y+~deltsf.at(2))%12)).asSet.includes(4)).if ({~bE.valueAction = 1}, {~bE.valueAction = 3});
	((x++((y+~deltsf.at(2))%12)).asSet.includes(5)).if ({~bF.valueAction = 1}, {~bF.valueAction = 3});
	((x++((y+~deltsf.at(2))%12)).asSet.includes(6)).if ({~bGb.valueAction = 1}, {~bGb.valueAction = 3});
	((x++((y+~deltsf.at(2))%12)).asSet.includes(7)).if ({~bG.valueAction = 1}, {~bG.valueAction = 3});
	((x++((y+~deltsf.at(2))%12)).asSet.includes(8)).if ({~bAb.valueAction = 1}, {~bAb.valueAction = 3});
	((x++((y+~deltsf.at(2))%12)).asSet.includes(9)).if ({~bA.valueAction = 1}, {~bA.valueAction = 3});
	((x++((y+~deltsf.at(2))%12)).asSet.includes(10)).if ({~bBb.valueAction = 1}, {~bBb.valueAction = 3});
	((x++((y+~deltsf.at(2))%12)).asSet.includes(11)).if ({~bB.valueAction = 1}, {~bB.valueAction = 3});
	(~delts.at(2)+1 * d).yield;
	AppClock.play(~gate3);
});

~secD = Routine.new({
	~toptex.string = "Section D"; AppClock.play(~yD);
	~xvec = [(~tmat.rowAt(3).occurrencesOf(1) + ~tmat.rowAt(3).occurrencesOf(11)), (~tmat.rowAt(3).occurrencesOf(2) + ~tmat.rowAt(3).occurrencesOf(10)),
		(~tmat.rowAt(3).occurrencesOf(3) + ~tmat.rowAt(3).occurrencesOf(9)), (~tmat.rowAt(3).occurrencesOf(4) + ~tmat.rowAt(3).occurrencesOf(8)),
		(~tmat.rowAt(3).occurrencesOf(5) + ~tmat.rowAt(3).occurrencesOf(7)), (~tmat.rowAt(3).occurrencesOf(6))];
	~xscor = (~tscor - (([1,2,3,4,5,6] * ~xvec).sum / ~xvec.sum));
	~xdb = ((~xscor+1.75)/3.5);
	~xtime = (((~tmat.rowAt(3)+0.1).mean)/8);
	~den.value_(~xtime);
	~dyn.value_(~xdb);
	((x++((y+~deltsf.at(3))%12)).asSet.includes(0)).if ({~bC.valueAction = 1}, {~bC.valueAction = 3});
	((x++((y+~deltsf.at(3))%12)).asSet.includes(1)).if ({~bDb.valueAction = 1}, {~bDb.valueAction = 3});
	((x++((y+~deltsf.at(3))%12)).asSet.includes(2)).if ({~bD.valueAction = 1}, {~bD.valueAction = 3});
	((x++((y+~deltsf.at(3))%12)).asSet.includes(3)).if ({~bEb.valueAction = 1}, {~bEb.valueAction = 3});
	((x++((y+~deltsf.at(3))%12)).asSet.includes(4)).if ({~bE.valueAction = 1}, {~bE.valueAction = 3});
	((x++((y+~deltsf.at(3))%12)).asSet.includes(5)).if ({~bF.valueAction = 1}, {~bF.valueAction = 3});
	((x++((y+~deltsf.at(3))%12)).asSet.includes(6)).if ({~bGb.valueAction = 1}, {~bGb.valueAction = 3});
	((x++((y+~deltsf.at(3))%12)).asSet.includes(7)).if ({~bG.valueAction = 1}, {~bG.valueAction = 3});
	((x++((y+~deltsf.at(3))%12)).asSet.includes(8)).if ({~bAb.valueAction = 1}, {~bAb.valueAction = 3});
	((x++((y+~deltsf.at(3))%12)).asSet.includes(9)).if ({~bA.valueAction = 1}, {~bA.valueAction = 3});
	((x++((y+~deltsf.at(3))%12)).asSet.includes(10)).if ({~bBb.valueAction = 1}, {~bBb.valueAction = 3});
	((x++((y+~deltsf.at(3))%12)).asSet.includes(11)).if ({~bB.valueAction = 1}, {~bB.valueAction = 3});
	(~delts.at(3)+1 * d).yield;
	AppClock.play(~gate4);
});

~secE = Routine.new({
	~toptex.string = "Section E"; AppClock.play(~yE);
	~xvec = [(~tmat.rowAt(4).occurrencesOf(1) + ~tmat.rowAt(4).occurrencesOf(11)), (~tmat.rowAt(4).occurrencesOf(2) + ~tmat.rowAt(4).occurrencesOf(10)),
		(~tmat.rowAt(4).occurrencesOf(3) + ~tmat.rowAt(4).occurrencesOf(9)), (~tmat.rowAt(4).occurrencesOf(4) + ~tmat.rowAt(4).occurrencesOf(8)),
		(~tmat.rowAt(4).occurrencesOf(5) + ~tmat.rowAt(4).occurrencesOf(7)), (~tmat.rowAt(4).occurrencesOf(6))];
	~xscor = (~tscor - (([1,2,3,4,5,6] * ~xvec).sum / ~xvec.sum));
	~xdb = ((~xscor+1.75)/3.5);
	~xtime = (((~tmat.rowAt(4)+0.1).mean)/8);
	~den.value_(~xtime);
	~dyn.value_(~xdb);
	((x++((y+~deltsf.at(4))%12)).asSet.includes(0)).if ({~bC.valueAction = 1}, {~bC.valueAction = 3});
	((x++((y+~deltsf.at(4))%12)).asSet.includes(1)).if ({~bDb.valueAction = 1}, {~bDb.valueAction = 3});
	((x++((y+~deltsf.at(4))%12)).asSet.includes(2)).if ({~bD.valueAction = 1}, {~bD.valueAction = 3});
	((x++((y+~deltsf.at(4))%12)).asSet.includes(3)).if ({~bEb.valueAction = 1}, {~bEb.valueAction = 3});
	((x++((y+~deltsf.at(4))%12)).asSet.includes(4)).if ({~bE.valueAction = 1}, {~bE.valueAction = 3});
	((x++((y+~deltsf.at(4))%12)).asSet.includes(5)).if ({~bF.valueAction = 1}, {~bF.valueAction = 3});
	((x++((y+~deltsf.at(4))%12)).asSet.includes(6)).if ({~bGb.valueAction = 1}, {~bGb.valueAction = 3});
	((x++((y+~deltsf.at(4))%12)).asSet.includes(7)).if ({~bG.valueAction = 1}, {~bG.valueAction = 3});
	((x++((y+~deltsf.at(4))%12)).asSet.includes(8)).if ({~bAb.valueAction = 1}, {~bAb.valueAction = 3});
	((x++((y+~deltsf.at(4))%12)).asSet.includes(9)).if ({~bA.valueAction = 1}, {~bA.valueAction = 3});
	((x++((y+~deltsf.at(4))%12)).asSet.includes(10)).if ({~bBb.valueAction = 1}, {~bBb.valueAction = 3});
	((x++((y+~deltsf.at(4))%12)).asSet.includes(11)).if ({~bB.valueAction = 1}, {~bB.valueAction = 3});
	(~delts.at(4)+1 * d).yield;
	AppClock.play(~gate5);
});

~secF = Routine.new({
	~toptex.string = "Section F"; AppClock.play(~yF);
	~xvec = [(~tmat.rowAt(5).occurrencesOf(1) + ~tmat.rowAt(5).occurrencesOf(11)), (~tmat.rowAt(5).occurrencesOf(2) + ~tmat.rowAt(5).occurrencesOf(10)),
		(~tmat.rowAt(5).occurrencesOf(3) + ~tmat.rowAt(5).occurrencesOf(9)), (~tmat.rowAt(5).occurrencesOf(4) + ~tmat.rowAt(5).occurrencesOf(8)),
		(~tmat.rowAt(5).occurrencesOf(5) + ~tmat.rowAt(5).occurrencesOf(7)), (~tmat.rowAt(5).occurrencesOf(6))];
	~xscor = (~tscor - (([1,2,3,4,5,6] * ~xvec).sum / ~xvec.sum));
	~xdb = ((~xscor+1.75)/3.5);
	~xtime = (((~tmat.rowAt(5)+0.1).mean)/8);
	~den.value_(~xtime);
	~dyn.value_(~xdb);
	((x++((y+~deltsf.at(5))%12)).asSet.includes(0)).if ({~bC.valueAction = 1}, {~bC.valueAction = 3});
	((x++((y+~deltsf.at(5))%12)).asSet.includes(1)).if ({~bDb.valueAction = 1}, {~bDb.valueAction = 3});
	((x++((y+~deltsf.at(5))%12)).asSet.includes(2)).if ({~bD.valueAction = 1}, {~bD.valueAction = 3});
	((x++((y+~deltsf.at(5))%12)).asSet.includes(3)).if ({~bEb.valueAction = 1}, {~bEb.valueAction = 3});
	((x++((y+~deltsf.at(5))%12)).asSet.includes(4)).if ({~bE.valueAction = 1}, {~bE.valueAction = 3});
	((x++((y+~deltsf.at(5))%12)).asSet.includes(5)).if ({~bF.valueAction = 1}, {~bF.valueAction = 3});
	((x++((y+~deltsf.at(5))%12)).asSet.includes(6)).if ({~bGb.valueAction = 1}, {~bGb.valueAction = 3});
	((x++((y+~deltsf.at(5))%12)).asSet.includes(7)).if ({~bG.valueAction = 1}, {~bG.valueAction = 3});
	((x++((y+~deltsf.at(5))%12)).asSet.includes(8)).if ({~bAb.valueAction = 1}, {~bAb.valueAction = 3});
	((x++((y+~deltsf.at(5))%12)).asSet.includes(9)).if ({~bA.valueAction = 1}, {~bA.valueAction = 3});
	((x++((y+~deltsf.at(5))%12)).asSet.includes(10)).if ({~bBb.valueAction = 1}, {~bBb.valueAction = 3});
	((x++((y+~deltsf.at(5))%12)).asSet.includes(11)).if ({~bB.valueAction = 1}, {~bB.valueAction = 3});
	(~delts.at(5)+1 * d).yield;
	AppClock.play(~gate6);
});

~secG = Routine.new({
	~toptex.string = "Section G"; AppClock.play(~yG);
	~xvec = [(~tmat.rowAt(6).occurrencesOf(1) + ~tmat.rowAt(6).occurrencesOf(11)), (~tmat.rowAt(6).occurrencesOf(2) + ~tmat.rowAt(6).occurrencesOf(10)),
		(~tmat.rowAt(6).occurrencesOf(3) + ~tmat.rowAt(6).occurrencesOf(9)), (~tmat.rowAt(6).occurrencesOf(4) + ~tmat.rowAt(6).occurrencesOf(8)),
		(~tmat.rowAt(6).occurrencesOf(5) + ~tmat.rowAt(6).occurrencesOf(7)), (~tmat.rowAt(6).occurrencesOf(6))];
	~xscor = (~tscor - (([1,2,3,4,5,6] * ~xvec).sum / ~xvec.sum));
	~xdb = ((~xscor+1.75)/3.5);
	~xtime = (((~tmat.rowAt(6)+0.1).mean)/8);
	~den.value_(~xtime);
	~dyn.value_(~xdb);
	((x++((y+~deltsf.at(6))%12)).asSet.includes(0)).if ({~bC.valueAction = 1}, {~bC.valueAction = 3});
	((x++((y+~deltsf.at(6))%12)).asSet.includes(1)).if ({~bDb.valueAction = 1}, {~bDb.valueAction = 3});
	((x++((y+~deltsf.at(6))%12)).asSet.includes(2)).if ({~bD.valueAction = 1}, {~bD.valueAction = 3});
	((x++((y+~deltsf.at(6))%12)).asSet.includes(3)).if ({~bEb.valueAction = 1}, {~bEb.valueAction = 3});
	((x++((y+~deltsf.at(6))%12)).asSet.includes(4)).if ({~bE.valueAction = 1}, {~bE.valueAction = 3});
	((x++((y+~deltsf.at(6))%12)).asSet.includes(5)).if ({~bF.valueAction = 1}, {~bF.valueAction = 3});
	((x++((y+~deltsf.at(6))%12)).asSet.includes(6)).if ({~bGb.valueAction = 1}, {~bGb.valueAction = 3});
	((x++((y+~deltsf.at(6))%12)).asSet.includes(7)).if ({~bG.valueAction = 1}, {~bG.valueAction = 3});
	((x++((y+~deltsf.at(6))%12)).asSet.includes(8)).if ({~bAb.valueAction = 1}, {~bAb.valueAction = 3});
	((x++((y+~deltsf.at(6))%12)).asSet.includes(9)).if ({~bA.valueAction = 1}, {~bA.valueAction = 3});
	((x++((y+~deltsf.at(6))%12)).asSet.includes(10)).if ({~bBb.valueAction = 1}, {~bBb.valueAction = 3});
	((x++((y+~deltsf.at(6))%12)).asSet.includes(11)).if ({~bB.valueAction = 1}, {~bB.valueAction = 3});
	(~delts.at(6)+1 * d).yield;
	AppClock.play(~gate7);
});

~secH = Routine.new({
	~toptex.string = "Section H"; AppClock.play(~yH);
	~xvec = [(~tmat.rowAt(7).occurrencesOf(1) + ~tmat.rowAt(7).occurrencesOf(11)), (~tmat.rowAt(7).occurrencesOf(2) + ~tmat.rowAt(7).occurrencesOf(10)),
		(~tmat.rowAt(7).occurrencesOf(3) + ~tmat.rowAt(7).occurrencesOf(9)), (~tmat.rowAt(7).occurrencesOf(4) + ~tmat.rowAt(7).occurrencesOf(8)),
		(~tmat.rowAt(7).occurrencesOf(5) + ~tmat.rowAt(7).occurrencesOf(7)), (~tmat.rowAt(7).occurrencesOf(6))];
	~xscor = (~tscor - (([1,2,3,4,5,6] * ~xvec).sum / ~xvec.sum));
	~xdb = ((~xscor+1.75)/3.5);
	~xtime = (((~tmat.rowAt(7)+0.1).mean)/8);
	~den.value_(~xtime);
	~dyn.value_(~xdb);
	((x++((y+~deltsf.at(7))%12)).asSet.includes(0)).if ({~bC.valueAction = 1}, {~bC.valueAction = 3});
	((x++((y+~deltsf.at(7))%12)).asSet.includes(1)).if ({~bDb.valueAction = 1}, {~bDb.valueAction = 3});
	((x++((y+~deltsf.at(7))%12)).asSet.includes(2)).if ({~bD.valueAction = 1}, {~bD.valueAction = 3});
	((x++((y+~deltsf.at(7))%12)).asSet.includes(3)).if ({~bEb.valueAction = 1}, {~bEb.valueAction = 3});
	((x++((y+~deltsf.at(7))%12)).asSet.includes(4)).if ({~bE.valueAction = 1}, {~bE.valueAction = 3});
	((x++((y+~deltsf.at(7))%12)).asSet.includes(5)).if ({~bF.valueAction = 1}, {~bF.valueAction = 3});
	((x++((y+~deltsf.at(7))%12)).asSet.includes(6)).if ({~bGb.valueAction = 1}, {~bGb.valueAction = 3});
	((x++((y+~deltsf.at(7))%12)).asSet.includes(7)).if ({~bG.valueAction = 1}, {~bG.valueAction = 3});
	((x++((y+~deltsf.at(7))%12)).asSet.includes(8)).if ({~bAb.valueAction = 1}, {~bAb.valueAction = 3});
	((x++((y+~deltsf.at(7))%12)).asSet.includes(9)).if ({~bA.valueAction = 1}, {~bA.valueAction = 3});
	((x++((y+~deltsf.at(7))%12)).asSet.includes(10)).if ({~bBb.valueAction = 1}, {~bBb.valueAction = 3});
	((x++((y+~deltsf.at(7))%12)).asSet.includes(11)).if ({~bB.valueAction = 1}, {~bB.valueAction = 3});
	(~delts.at(7)+1 * d).yield;
	AppClock.play(~gate8);
});

~secI = Routine.new({
	~toptex.string = "Section I"; AppClock.play(~yI);
	~xvec = [(~tmat.rowAt(8).occurrencesOf(1) + ~tmat.rowAt(8).occurrencesOf(11)), (~tmat.rowAt(8).occurrencesOf(2) + ~tmat.rowAt(8).occurrencesOf(10)),
		(~tmat.rowAt(8).occurrencesOf(3) + ~tmat.rowAt(8).occurrencesOf(9)), (~tmat.rowAt(8).occurrencesOf(4) + ~tmat.rowAt(8).occurrencesOf(8)),
		(~tmat.rowAt(8).occurrencesOf(5) + ~tmat.rowAt(8).occurrencesOf(7)), (~tmat.rowAt(8).occurrencesOf(6))];
	~xscor = (~tscor - (([1,2,3,4,5,6] * ~xvec).sum / ~xvec.sum));
	~xdb = ((~xscor+1.75)/3.5);
	~xtime = (((~tmat.rowAt(8)+1).sputter(0.8).mean)/8);
	~den.value_(~xtime);
	~dyn.value_(~xdb);
	((x++((y+~deltsf.at(8))%12)).asSet.includes(0)).if ({~bC.valueAction = 1}, {~bC.valueAction = 3});
	((x++((y+~deltsf.at(8))%12)).asSet.includes(1)).if ({~bDb.valueAction = 1}, {~bDb.valueAction = 3});
	((x++((y+~deltsf.at(8))%12)).asSet.includes(2)).if ({~bD.valueAction = 1}, {~bD.valueAction = 3});
	((x++((y+~deltsf.at(8))%12)).asSet.includes(3)).if ({~bEb.valueAction = 1}, {~bEb.valueAction = 3});
	((x++((y+~deltsf.at(8))%12)).asSet.includes(4)).if ({~bE.valueAction = 1}, {~bE.valueAction = 3});
	((x++((y+~deltsf.at(8))%12)).asSet.includes(5)).if ({~bF.valueAction = 1}, {~bF.valueAction = 3});
	((x++((y+~deltsf.at(8))%12)).asSet.includes(6)).if ({~bGb.valueAction = 1}, {~bGb.valueAction = 3});
	((x++((y+~deltsf.at(8))%12)).asSet.includes(7)).if ({~bG.valueAction = 1}, {~bG.valueAction = 3});
	((x++((y+~deltsf.at(8))%12)).asSet.includes(8)).if ({~bAb.valueAction = 1}, {~bAb.valueAction = 3});
	((x++((y+~deltsf.at(8))%12)).asSet.includes(9)).if ({~bA.valueAction = 1}, {~bA.valueAction = 3});
	((x++((y+~deltsf.at(8))%12)).asSet.includes(10)).if ({~bBb.valueAction = 1}, {~bBb.valueAction = 3});
	((x++((y+~deltsf.at(8))%12)).asSet.includes(11)).if ({~bB.valueAction = 1}, {~bB.valueAction = 3});
	(~delts.at(8)+1 * d).yield;
	AppClock.play(~fin);
});

//sound making routines*****sound making routines
~ypre = Routine.new({
	~octave = [[48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble];
	z = Pbind(
		\instrument, \virtmarimba,
		\buf, Pseq(y+~octave.lace(y.size)),
		\dur, Prand([0.8,0.85,0.9,0.95,1,1.05,1.1],y.size),
		\amp, 0.5,
	).play; AppClock.play(~begin);
});

~yA = Routine.new({
	~octave = [[48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble];
	~yvec = [(~tmat.colAt(0).occurrencesOf(1) + ~tmat.colAt(0).occurrencesOf(11)), (~tmat.colAt(0).occurrencesOf(2) + ~tmat.colAt(0).occurrencesOf(10)),
		(~tmat.colAt(0).occurrencesOf(3) + ~tmat.colAt(0).occurrencesOf(9)), (~tmat.colAt(0).occurrencesOf(4) + ~tmat.colAt(0).occurrencesOf(8)),
		(~tmat.colAt(0).occurrencesOf(5) + ~tmat.colAt(0).occurrencesOf(7)), (~tmat.colAt(0).occurrencesOf(6))];
	~yscor = (~tscor - (([1,2,3,4,5,6] * ~yvec).sum / ~yvec.sum));
	~db = ((Array.exprand(10, 0.1, 0.5)*~yscor)+0.5);
	~notemake = (y++((x-~deltsf.at(0))%12)).sputter(0.5);
	~note = (~notemake+~octave.lace(~notemake.size)).sputter(0.2);
	~timemake = (~tmat.colAt(0)*0.5).sputter(0.8);
	~time = (Array.exprand(~timemake.size, 0.001, 0.4)+~timemake);
	z = Pbind(
		\instrument, \virtmarimba,
		\buf, Prand(~note, inf),
		\dur, Prand(~time, inf),
		\amp, Prand(~db, inf),
	).play; ((~delts.at(0)+1 * d)-0.3).yield; z.stop;
});

~yB = Routine.new({
	~octave = [[48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble];
	~yvec = [(~tmat.colAt(1).occurrencesOf(1) + ~tmat.colAt(1).occurrencesOf(11)), (~tmat.colAt(1).occurrencesOf(2) + ~tmat.colAt(1).occurrencesOf(10)),
		(~tmat.colAt(1).occurrencesOf(3) + ~tmat.colAt(1).occurrencesOf(9)), (~tmat.colAt(1).occurrencesOf(4) + ~tmat.colAt(1).occurrencesOf(8)),
		(~tmat.colAt(1).occurrencesOf(5) + ~tmat.colAt(1).occurrencesOf(7)), (~tmat.colAt(1).occurrencesOf(6))];
	~yscor = (~tscor - (([1,2,3,4,5,6] * ~yvec).sum / ~yvec.sum));
	~db = ((Array.exprand(10, 0.1, 0.5)*~yscor)+0.5);
	~note = (y++(x-~deltsf.at(1)))+~octave.lace(y.size).sputter(0.2);
	~timemake = (~tmat.colAt(1)*0.5).sputter(0.8);
	~time = (Array.exprand(~timemake.size, 0.001, 0.4)+~timemake);
	z = Pbind(
		\instrument, \virtmarimba,
		\buf, Prand(~note, inf),
		\dur, Prand(~time, inf),
		\amp, 0.5,
	).play; ((~delts.at(1)+1 * d)-0.3).yield; z.stop;
});

~yC = Routine.new({
	~octave = [[48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble];
	~yvec = [(~tmat.colAt(2).occurrencesOf(1) + ~tmat.colAt(2).occurrencesOf(11)), (~tmat.colAt(2).occurrencesOf(2) + ~tmat.colAt(2).occurrencesOf(10)),
		(~tmat.colAt(2).occurrencesOf(3) + ~tmat.colAt(2).occurrencesOf(9)), (~tmat.colAt(2).occurrencesOf(4) + ~tmat.colAt(2).occurrencesOf(8)),
		(~tmat.colAt(2).occurrencesOf(5) + ~tmat.colAt(2).occurrencesOf(7)), (~tmat.colAt(2).occurrencesOf(6))];
	~yscor = (~tscor - (([1,2,3,4,5,6] * ~yvec).sum / ~yvec.sum));
	~db = ((Array.exprand(10, 0.1, 0.5)*~yscor)+0.5);
	~note = (y++(x-~deltsf.at(2)))+~octave.lace(y.size).sputter(0.2);
	~timemake = (~tmat.colAt(2)*0.5).sputter(0.8);
	~time = (Array.exprand(~timemake.size, 0.001, 0.4)+~timemake);
	z = Pbind(
		\instrument, \virtmarimba,
		\buf, Prand(~note, inf),
		\dur, Prand(~time, inf),
		\amp, 0.5,
	).play; ((~delts.at(2)+1 * d)-0.3).yield; z.stop;
});

~yD = Routine.new({
	~octave = [[48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble];
	~yvec = [(~tmat.colAt(3).occurrencesOf(1) + ~tmat.colAt(3).occurrencesOf(11)), (~tmat.colAt(3).occurrencesOf(2) + ~tmat.colAt(3).occurrencesOf(10)),
		(~tmat.colAt(3).occurrencesOf(3) + ~tmat.colAt(3).occurrencesOf(9)), (~tmat.colAt(3).occurrencesOf(4) + ~tmat.colAt(3).occurrencesOf(8)),
		(~tmat.colAt(3).occurrencesOf(5) + ~tmat.colAt(3).occurrencesOf(7)), (~tmat.colAt(3).occurrencesOf(6))];
	~yscor = (~tscor - (([1,2,3,4,5,6] * ~yvec).sum / ~yvec.sum));
	~db = ((Array.exprand(10, 0.1, 0.5)*~yscor)+0.5);
	~note = (y++(x-~deltsf.at(3)))+~octave.lace(y.size).sputter(0.2);
	~timemake = (~tmat.colAt(3)*0.5).sputter(0.8);
	~time = (Array.exprand(~timemake.size, 0.001, 0.4)+~timemake);
	z = Pbind(
		\instrument, \virtmarimba,
		\buf, Prand(~note, inf),
		\dur, Prand(~time, inf),
		\amp, 0.5,
	).play; ((~delts.at(3)+1 * d)-0.3).yield; z.stop;
});

~yE = Routine.new({
	~octave = [[48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble];
	~yvec = [(~tmat.colAt(4).occurrencesOf(1) + ~tmat.colAt(4).occurrencesOf(11)), (~tmat.colAt(4).occurrencesOf(2) + ~tmat.colAt(4).occurrencesOf(10)),
		(~tmat.colAt(4).occurrencesOf(3) + ~tmat.colAt(4).occurrencesOf(9)), (~tmat.colAt(4).occurrencesOf(4) + ~tmat.colAt(4).occurrencesOf(8)),
		(~tmat.colAt(4).occurrencesOf(5) + ~tmat.colAt(4).occurrencesOf(7)), (~tmat.colAt(4).occurrencesOf(6))];
	~yscor = (~tscor - (([1,2,3,4,5,6] * ~yvec).sum / ~yvec.sum));
	~db = ((Array.exprand(10, 0.1, 0.5)*~yscor)+0.5);
	~note = (y++(x-~deltsf.at(4)))+~octave.lace(y.size).sputter(0.2);
	~timemake = (~tmat.colAt(4)*0.5).sputter(0.8);
	~time = (Array.exprand(~timemake.size, 0.001, 0.4)+~timemake);
	z = Pbind(
		\instrument, \virtmarimba,
		\buf, Prand(~note, inf),
		\dur, Prand(~time, inf),
		\amp, 0.5,
	).play; ((~delts.at(4)+1 * d)-0.3).yield; z.stop;
});

~yF = Routine.new({
	~octave = [[48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble];
	~yvec = [(~tmat.colAt(5).occurrencesOf(1) + ~tmat.colAt(5).occurrencesOf(11)), (~tmat.colAt(5).occurrencesOf(2) + ~tmat.colAt(5).occurrencesOf(10)),
		(~tmat.colAt(5).occurrencesOf(3) + ~tmat.colAt(5).occurrencesOf(9)), (~tmat.colAt(5).occurrencesOf(4) + ~tmat.colAt(5).occurrencesOf(8)),
		(~tmat.colAt(5).occurrencesOf(5) + ~tmat.colAt(5).occurrencesOf(7)), (~tmat.colAt(5).occurrencesOf(6))];
	~yscor = (~tscor - (([1,2,3,4,5,6] * ~yvec).sum / ~yvec.sum));
	~db = ((Array.exprand(10, 0.1, 0.5)*~yscor)+0.5);
	~note = (y++(x-~deltsf.at(5)))+~octave.lace(y.size).sputter(0.2);
	~timemake = (~tmat.colAt(5)*0.5).sputter(0.8);
	~time = (Array.exprand(~timemake.size, 0.001, 0.4)+~timemake);
	z = Pbind(
		\instrument, \virtmarimba,
		\buf, Prand(~note, inf),
		\dur, Prand(~time, inf),
		\amp, 0.5,
	).play; ((~delts.at(5)+1 * d)-0.3).yield; z.stop;
});

~yG = Routine.new({
	~octave = [[48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble];
	~yvec = [(~tmat.colAt(6).occurrencesOf(1) + ~tmat.colAt(6).occurrencesOf(11)), (~tmat.colAt(6).occurrencesOf(2) + ~tmat.colAt(6).occurrencesOf(10)),
		(~tmat.colAt(6).occurrencesOf(3) + ~tmat.colAt(6).occurrencesOf(9)), (~tmat.colAt(6).occurrencesOf(4) + ~tmat.colAt(6).occurrencesOf(8)),
		(~tmat.colAt(6).occurrencesOf(5) + ~tmat.colAt(6).occurrencesOf(7)), (~tmat.colAt(6).occurrencesOf(6))];
	~yscor = (~tscor - (([1,2,3,4,5,6] * ~yvec).sum / ~yvec.sum));
	~db = ((Array.exprand(10, 0.1, 0.5)*~yscor)+0.5);
	~note = (y++(x-~deltsf.at(6)))+~octave.lace(y.size).sputter(0.2);
	~timemake = (~tmat.colAt(6)*0.5).sputter(0.8);
	~time = (Array.exprand(~timemake.size, 0.001, 0.4)+~timemake);
	z = Pbind(
		\instrument, \virtmarimba,
		\buf, Prand(~note, inf),
		\dur, Prand(~time, inf),
		\amp, 0.5,
	).play; ((~delts.at(6)+1 * d)-0.3).yield; z.stop;
});

~yH = Routine.new({
	~octave = [[48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble];
	~yvec = [(~tmat.colAt(7).occurrencesOf(1) + ~tmat.colAt(7).occurrencesOf(11)), (~tmat.colAt(7).occurrencesOf(2) + ~tmat.colAt(7).occurrencesOf(10)),
		(~tmat.colAt(7).occurrencesOf(3) + ~tmat.colAt(7).occurrencesOf(9)), (~tmat.colAt(7).occurrencesOf(4) + ~tmat.colAt(7).occurrencesOf(8)),
		(~tmat.colAt(7).occurrencesOf(5) + ~tmat.colAt(7).occurrencesOf(7)), (~tmat.colAt(7).occurrencesOf(6))];
	~yscor = (~tscor - (([1,2,3,4,5,6] * ~yvec).sum / ~yvec.sum));
	~db = ((Array.exprand(10, 0.1, 0.5)*~yscor)+0.5);
	~note = (y++(x-~deltsf.at(7)))+~octave.lace(y.size).sputter(0.5);
	~timemake = (~tmat.colAt(7)*0.5).sputter(0.8);
	~time = (Array.exprand(~timemake.size, 0.001, 0.4)+~timemake);
	z = Pbind(
		\instrument, \virtmarimba,
		\buf, Prand(~note, inf),
		\dur, Prand(~time, inf),
		\amp, 0.5,
	).play; ((~delts.at(7)+1 * d)-0.3).yield; z.stop;
});

~yI = Routine.new({
	~octave = [[48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble, [48, 60, 72].scramble];
	~yvec = [(~tmat.colAt(8).occurrencesOf(1) + ~tmat.colAt(8).occurrencesOf(11)), (~tmat.colAt(8).occurrencesOf(2) + ~tmat.colAt(8).occurrencesOf(10)),
		(~tmat.colAt(8).occurrencesOf(3) + ~tmat.colAt(8).occurrencesOf(9)), (~tmat.colAt(8).occurrencesOf(4) + ~tmat.colAt(8).occurrencesOf(8)),
		(~tmat.colAt(8).occurrencesOf(5) + ~tmat.colAt(8).occurrencesOf(7)), (~tmat.colAt(8).occurrencesOf(6))];
	~yscor = (~tscor - (([1,2,3,4,5,6] * ~yvec).sum / ~yvec.sum));
	~db = ((Array.exprand(10, 0.1, 0.5)*~yscor)+0.5);
	~note = (y++(x-~deltsf.at(8)))+~octave.lace(y.size).sputter(0.5);
	~timemake = (~tmat.colAt(8)*0.5).sputter(0.8);
	~time = (Array.exprand(~timemake.size, 0.001, 0.4)+~timemake);
	z = Pbind(
		\instrument, \virtmarimba,
		\buf, Prand(~note, inf),
		\dur, Prand(~time, inf),
		\amp, 0.5,
	).play; ((~delts.at(8)+1 * d)-0.3).yield; z.stop;
});

//style/opening/textstorage*****style/opening/textstorage
~fone = Font("Times", 13);
~ftwo = Font("Times", 23);
~fthre = Font("Times", 17);
x = Array.new(12);
y = Array.new(12);
d = 13;
w = Window.new("Mutable Subjects", Rect(400, 200, 710, 500), false, true).front;
~title = StaticText(w, Rect(0, 10, 710, 20)).string = "Mutable Subjects                (for corporeal and virtual marimbas)"; ~title.font = ~fthre;
~composer = StaticText(w, Rect(105, 25, 500, 70)).string = "composed and created by Tucker Johnson"; ~composer.font = ~fone;
~start = Button(w, Rect(305, 100, 75, 75)).states_([["begin", Color.black, Color.rand], ["begin", Color.black, Color.white]]).mouseDownAction_({
	~title.remove; ~composer.remove; ~start.remove; AppClock.play(~begin); s.boot;}); ~start.font = ~ftwo;
~title.align = \center;
~introinstructionone = "Select a collection of between 3 and 9 pitches and play them in any octave. Then ADVANCE.";
~introinstructiontwo = "Virtual marimba will select a pitch collection of the same size and perform it. Then the piece will automatically continue to section 1";


~begin = Routine.new({

	~load = StaticText(w, Rect(0, 90, 300, 20)).string = "LOADING";
	~load.align = \center; ~load.font = ~fthre; 0.5.yield;
	~load.stringColor = Color.rand; 0.3.yield; ~load.stringColor = Color.rand; 0.2.yield;
	~load.stringColor = Color.rand; 0.3.yield; ~load.stringColor = Color.rand; 0.5.yield;
	~load.stringColor = Color.rand; 0.3.yield; ~load.stringColor = Color.rand; 0.5.yield;
	~load.stringColor = Color.rand; 0.3.yield; ~load.stringColor = Color.rand; 0.2.yield;
	~load.remove; 0.2.yield;
	~toptex = StaticText(w, Rect(0, 10, 710, 20)).align = \center; ~toptex.font = ~fthre; ~toptex.string = "Introduction";
	~instruc = StaticText(w, Rect(105, 25, 500, 70)).align = \center; ~instruc.font = ~fone; ~instruc.string = ~introinstructionone;
	~ydisp = StaticText(w, Rect(0, 210, 710, 50)).align = \center; ~ydisp.font = ~ftwo; ~ydisp.string = y;
	~xdisp = StaticText(w, Rect(0, 210, 710, 100)).align = \center; ~xdisp.font = ~ftwo; ~xdisp.string = x;
	~bC = Button(w, Rect(10, 400, 90, 90)).states_([["C", Color.black, Color.rand], ["C", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bC.acceptsMouse = false; x.add(0); ~xdisp.string = x; }); ~bC.font = ~ftwo;
	~bDb = Button(w, Rect(60, 300, 90, 90)).states_([["Db", Color.black, Color.rand], ["Db", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bDb.acceptsMouse = false; x.add(1); ~xdisp.string = x; }); ~bDb.font = ~ftwo;
	~bD = Button(w, Rect(110, 400, 90, 90)).states_([["D", Color.black, Color.rand], ["D", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bD.acceptsMouse = false; x.add(2); ~xdisp.string = x; }); ~bD.font = ~ftwo;
		~bEb = Button(w, Rect(160, 300, 90, 90)).states_([["Eb", Color.black, Color.rand], ["Eb", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bEb.acceptsMouse = false; x.add(3); ~xdisp.string = x; }); ~bEb.font = ~ftwo;
	~bE = Button(w, Rect(210, 400, 90, 90)).states_([["E", Color.black, Color.rand], ["E", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bE.acceptsMouse = false; x.add(4); ~xdisp.string = x; }); ~bE.font = ~ftwo;
	~bF = Button(w, Rect(310, 400, 90, 90)).states_([["F", Color.black, Color.rand], ["F", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bF.acceptsMouse = false; x.add(5); ~xdisp.string = x; }); ~bF.font = ~ftwo;
	~bGb = Button(w, Rect(360, 300, 90, 90)).states_([["Gb", Color.black, Color.rand], ["Gb", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bGb.acceptsMouse = false; x.add(6); ~xdisp.string = x; }); ~bGb.font = ~ftwo;
	~bG = Button(w, Rect(410, 400, 90, 90)).states_([["G", Color.black, Color.rand], ["G", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bG.acceptsMouse = false; x.add(7); ~xdisp.string = x; }); ~bG.font = ~ftwo;
	~bAb = Button(w, Rect(460, 300, 90, 90)).states_([["Ab", Color.black, Color.rand], ["Ab", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bAb.acceptsMouse = false; x.add(8); ~xdisp.string = x; }); ~bAb.font = ~ftwo;
	~bA = Button(w, Rect(510, 400, 90, 90)).states_([["A", Color.black, Color.rand], ["A", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bA.acceptsMouse = false; x.add(9); ~xdisp.string = x; }); ~bA.font = ~ftwo;
	~bBb = Button(w, Rect(560, 300, 90, 90)).states_([["Bb", Color.black, Color.rand], ["Bb", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bBb.acceptsMouse = false; x.add(10); ~xdisp.string = x; }); ~bBb.font = ~ftwo;
	~bB = Button(w, Rect(610, 400, 90, 90)).states_([["B", Color.black, Color.rand], ["B", Color.black, Color.white], ["E", Color.black, Color.black] ]).mouseDownAction_({
		~bB.acceptsMouse = false; x.add(11); ~xdisp.string = x; }); ~bB.font = ~ftwo;
	~adva = Button(w, Rect(325, 100, 55, 55)).font = ~ftwo;
	~adva.states_([["->", Color.black, Color.white], ["->", Color.black, Color.white]]).mouseDownAction_({ AppClock.play(~begin); }).yield;
	~adva.remove; ~bC.acceptsMouse = false; ~bDb.acceptsMouse = false; ~bD.acceptsMouse = false; ~bEb.acceptsMouse = false;
	~bE.acceptsMouse = false; ~bF.acceptsMouse = false; ~bGb.acceptsMouse = false; ~bG.acceptsMouse = false;
	~bAb.acceptsMouse = false; ~bA.acceptsMouse = false; ~bBb.acceptsMouse = false; ~bB.acceptsMouse = false;
	~instruc.string = ~introinstructiontwo; y = [0,1,2,3,4,5,6,7,8,9,10,11].scramble.clipExtend(x.size);
	~ypre.next; ~ydisp.string = y; (y.size+2).yield;
	~structure.next.yield; AppClock.play(~secA); AppClock.play(~tim);  ~instruc.remove; ~virt.remove;
	 ~xdisp.remove; ~ydisp.remove;
});


	"good to go bud"