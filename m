Return-Path: <cygwin-patches-return-2019-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32597 invoked by alias); 2 Apr 2002 21:13:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32583 invoked from network); 2 Apr 2002 21:13:33 -0000
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: "'Cygwin-Patches'" <cygwin-patches@sources.redhat.com>
Subject: RE: [PATCH] Setup Chooser integration
Date: Tue, 02 Apr 2002 13:13:00 -0000
Message-ID: <000c01c1da8b$604fb3f0$2101a8c0@BRAEMARINC.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000D_01C1DA59.15B543F0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-MS-TNEF-Correlator: 00000000B03CC41A0A406141B2DADC7F0FA7B35A247BCD00
In-Reply-To: <FC169E059D1A0442A04C40F86D9BA76008AC08@itdomain003.itdomain.net.au>
X-SW-Source: 2002-q2/txt/msg00003.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_000D_01C1DA59.15B543F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 3189

> Gary, I haven't reviewed this yet...
> 
> Can we, with the patch as is, do the following:
> 
> Pop up a chooser?
> 

If you're asking if there's still a do_choose(), the answer is no.  Does the
patch preclude such functionality?  No, but it would require additional
code.

> That's it. Nice and simple eh? Well, once I've got the 
> collection based
> PickView together, then that should be all there is to it.
> 
> What is this in aid of?
> 
> Image: you click on 'install' for 'gcc', and up pops a window 
> that lists
> everything that gcc depends on (both requires as we have today, and
> 'suggested' items that aren't always needed but are useful - ie
> autoconf), that was not selected before that click. 
> 

I'm drawing a blank at the utility of such a feature, at least in the guise
of a popup of any kind.  You're saying that as you go through the dozens of
packages you want and select them, that a box pops up bugging you about the
dependencies of each selection, which you can't do anything about anyways?
That sounds like it would be extremely irritating.

As for suggestions, mixing them in with dependencies sounds bad to me.
Don't the metapackages/"Wokstation/Sever/etc" ideas, however they end up
working out, handle suggested packages adequately?

> Likewise, if you click ash off, up pops a window listing 
> everything that
> depends on ash, with an addiotnal message of "Warning: 
> removing ash will
> cause these packages to be removed as well.
> 

This does make quite a bit of sense to me.  But wouldn't MessageBox() or
something akin to it be a better fit to the task?  The only possible user
input here would be "Yes, remove ash and everything dependent on it" and
"Cancel", and the only output a list of package names.

> So what I'm asking you now, is if your patch to the chooser 
> will work in
> with this long term plan, or are they orthogonal, or is it a step
> backwards?
> 

As I see it, all three:

- The long-term plan has to have at least the primary chooser integrated
into the Wizard.  This patch puts that one to bed.
- The changes required to fully implement what you've outlined above are
largely orthogonal to the relatively minor changes in this patch.
- There's no do_choose() exported anymore, so in that sense you could call
it a step back.  (You could, I wouldn't ;-)).

> I guess we could replace the view in-place within the setup window -
> maybe that would be better and cleaner? (Noting that the 
> PickView class
> is heading to be a win32 window with reflector inheriting from your
> Window class, so we need some way of removing/hiding the saved window
> and then restoring it...)
> 

Microsoft's own installers (e.g. Office) seem to work that way IIRC.  Then
again I've never been real crazy about their installers - things that seem
like they should be "tree-like" aren't (e.g. selecting sub-elements of a
package), and things are presented in tree-fashion that don't seem like they
should be (selecting the "install/install on demand/don't install").

> Anyway, is this clear as mud?
> 

Hey, if this stuff was easy, anybody could do it. ;-)

> Rob
> 

-- 
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337

------=_NextPart_000_000D_01C1DA59.15B543F0
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"
Content-length: 4714

eJ8+Ih0VAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcA
GAAAAElQTS5NaWNyb3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEG
gAMADgAAANIHBAACAA8ADgAAAAIA/gABA5AGABgNAAAlAAAACwACAAEAAAAL
ACMAAAAAAAMAJgAAAAAACwApAAAAAAADAC4AAAAAAAMANgAAAAAAHgBwAAEA
AAAiAAAAW1BBVENIXSBTZXR1cCBDaG9vc2VyIGludGVncmF0aW9uAAAAAgFx
AAEAAAAWAAAAAcHai1+M6j8p44OfQsePspzP5e/FBAAAAgEdDAEAAAAdAAAA
U01UUDpUSUJFUklVU0BCUkFFTUFSSU5DLkNPTQAAAAALAAEOAAAAAEAABg4A
HMZOi9rBAQIBCg4BAAAAGAAAAAAAAACwPMQaCkBhQbLa3H8Pp7NawoAAAAMA
FA4BAAAACwAfDgEAAAACAQkQAQAAAMMIAAC/CAAA1g4AAExaRnUg/numAwAK
AHJjcGcxMjXiMgNDdGV4BUEBAwH3/wqAAqQD5AcTAoAP8wBQBFY/CFUHshEl
DlEDAQIAY2jhCsBzZXQyBgAGwxEl9jMERhO3MBIsETMI7wn3tjsYHw4wNREi
DGBjAFAzCwkBZDM2FlALpiA+BCBHCsB5LCBJILUT4HYJ8CcFQBggdgiQIncJ
gCB0aAQAIHl9FCAuHyAKogqAHPAfVkM/A5EeYB1QA/AeoB6RZSDlCrB0E9Ag
YQQgBAAdUGxkbyETAhBsF7AD8G4EZzofXlBvcCB1SSRgYSAT0G9vFBByZj8f
XB9USWYe4AhgJ/sYICGxayMBIeAmoCEhGCDyJwQgc3QDEAMgJLAiMPJfJNQo
KR1QISIAcR5gAwXAHsFuby4gIETWbweRIShwGCBjCkABAIcoQBrQIQBmdW5j
KGAnAiAHQCDgeT8qsE5veR1QYnUFQCDgIIAIYGwjHoAYIHF1aScCZGS/IOAs
8yTABHEfRR9WVBPg7nQoISDgKqBODeApwh6ATQCQbQtQIUBlaC1wV55lIsAd
UAIgMeFJJx2w+CBnbwVAISIfVheRMpA/LNMt0CHACYAjxw3ga1bzHkEekG9n
FCAn4SmDA6DfHqAhcChAJOAucmInESiB3yfTKkI3EDFyH15XOBI5kpcesguA
IbBpHoBvZiVN7RzwSQDANzA6JrIkwC0wczagM1EgJwuAKFA48SeDIpEFwCdn
Y2MnHVD7MhIkgXAkUAQgJLAi8SIw3wfgH1Y4Ay0wKFBzH1YeIH0EkHkeoSdx
OAM/wSIgZdpwCfBkBCA1gSgG4CDxPy61QMEEIB5gHYM3AWRhzx1BMhEfVigg
dWc3MChQ5wmAP1Ag4GVtKwI4IQrA+x3DB0B3RtAqYQngAQA4ob8t8UkxJHAU
ECygAyAtIeAqZR9WYS3wbwWgbmb/KXM4IUnAKmI4MTMQNUFKUv8BEAWwRoE4
Ej5DKqAlXyZi5CdtIiByYSLyJKECYP8AcD6AOCEhIi3wAxAtQTxR8yxEJLBm
ZSFwCHAgoUIS71OQKFA74iEiZy7gFBBS0m8ksECRJIFVcm5SwCdRZPUqoVkm
1HNG0EOHIcE+Ar80AB6RA2BH4CEEIjB6CfD/RLEmoAqwNqA9sVhEScACMDcy
BE3DIRJtTMVRcW94/0CEJIEt4EfwJ2I+AgGgCGD3NCREVAnwYwiQWeNTkCGR
/020LPEgsR6wIZE+AwBwHeH/IjFWUUNkXlRWUUnCLXExEu8oQAhgRJItMGs5
cS42OMH3DsEYIAeAbFLALvAFEAGQ9yhgIxAwK0EEID9yR9Us8fEiAW1peEOE
SKA74iDT/177ZAU1sB6BIkAHgCqjHdIPISIHgAGQWjYvIldvtms/ASziLwZg
QyEvFCD8YyIh4AEAIcAdUCTgHmC/QyEhElLARIEkci5QcidT/15xb0EyETKR
R9daKC8wLsHvIXBl4SVFH1ZMZIED8SCh3yehPgghwCEAPGBmHVBAb/9CQidi
Qp9DpB9WRFl2ESC1/wORLzI0EC+iB4FXcDcwUtK/bYAKwAMAIxEfx2Wxbx4w
/1FCdiED8CLANIdMMFVBISH/VUFaNznBOMF+Ex5xRfMiwP86HR9UMRAewSIw
B5EAwGSR/y7RDrBRYi4hUuJZwUaCa7SuQi3xLlMd0k18VEJc4P8pYDNQZ+ED
cDdBUTMnUTm07zizOLECQBKBZi4hOcEhIu8BkCdAY4NVUW5l8UCQBBDuaQJg
SuMqMW5V4AVAOUP5ZPciWQeQHVCBVHYDMhJ/Qxle9oUhA6Ag4G7QMhIi8yBR
MeBsIkAEISKLk15x34ziJLBCQln5KnBhB4EwLf5TIkBg8DghULInNT4CKoD+
d3UhIdEmowXAIWSKdSTV/x/HfuJwkzvhmVgg8x7BF7D/Q5IEkFDQC1FgwQWx
SsJv4/8XwSTgNAAtEZyTO8Jckkgh/nAfVjWwNqBJwAsgY3CCX/9nZB1wFBBk
okABOQMJ0SM17x9US3CLUpuyLZwHHYE5o/9GU1QXISMFEADAHTCYxwuAPw6w
CcBzYR6Ap5EiRFdp/noLESqhg5MrZS3wSMUCIP+FszjAVsCjWhPRIxAHkS61
/2tzSzFl8jJyB4BbIZXDJsL/M9FecS0wShCBsQbgjqInAf0LYHI3MJKSnYeK
ZhggC2D/KGAdsGXxaNAqgAXArCZUo/+phqtaKAMqgCjKZXFAkAAg/4GiVmAE
YFPSZABUlDgihYN/PgMuY2GQKIGel5+TKqEoD1cBuLQdUoaXOy0pKf8wLR1w
VRB8UUYSuMQYIAtR7zHhISIeMjvhLb5UINJUpbcUEXByQRQtH1YAwHk4wf9M
5Dh2icUyEivwU5BKECUw/0TwLaB34zgDNEo2hyvwIcB/QocewSEwLzBDg4ED
QOMzbxRAQQUg0xggZjUynjJu/yfhL2EncQNSl6M6p0EUxoN/t1NGIUoSiBNN
IVLDfhYv/x6wx7TAUh2hHoBBBEu3kgTfA6BFscoBJ2MfEimgTx+B/k0N4ANg
ZAABgCghIuCQsTc+9ASQBCAoMBBmsCBP/wEgMdGH0KHRUNA5wZojTOXhUsBJ
SVJDqTM30T2w/wtxM6RKEG+iOMDRMy+yUQD+elLAXlcu8NSaS3BDY0jFL9Yz
ZHNv4zhYImWhZS1/ZHKQ8UlE1VRgRSdxLFBi/i1Nwa4SWeNVoVpEKXGR9H/c
E0rCK8GFcagEHpDeYmZ/dhE1cjgDIjAd0ty/OHYo69/YISIiPuUvPuU+kgEA
WQOBZC/lFD7lIrwuQf9jI5czHqPD0pzBhBEsEKA/vR9ySHAAdSMeoyhQdQEg
/00jVFFG48IABHCm8S5jIjH/MYK78TA8CAAMMO1vo5FLcK8fVB0SB/AqoFYD
kVM2kbsykB9UQlEA6UEFwEkswME6FTExNDgxB/AkgLkkYERyOhWGUASgcx4w
IzUhHVBNTiAaYDMzCjcfVH36UAAeAEIQAQAAAEUAAAA8RkMxNjlFMDU5RDFB
MDQ0MkEwNEM0MEY4NkQ5QkE3NjAwOEFDMDhAaXRkb21haW4wMDMuaXRkb21h
aW4ubmV0LmF1PgAAAAADAAlZAQAAAAsAAIAIIAYAAAAAAMAAAAAAAABGAAAA
AAOFAAAAAAAAAwACgAggBgAAAAAAwAAAAAAAAEYAAAAAEIUAAAAAAAADAAeA
CCAGAAAAAADAAAAAAAAARgAAAABShQAAtnQBAB4ACYAIIAYAAAAAAMAAAAAA
AABGAAAAAFSFAAABAAAABAAAADkuMAALABGACCAGAAAAAADAAAAAAAAARgAA
AAAGhQAAAAAAAAMAEoAIIAYAAAAAAMAAAAAAAABGAAAAAAGFAAAAAAAACwAb
gAggBgAAAAAAwAAAAAAAAEYAAAAADoUAAAAAAAADAByACCAGAAAAAADAAAAA
AAAARgAAAAARhQAAAAAAAAMAHoAIIAYAAAAAAMAAAAAAAABGAAAAABiFAAAA
AAAAAgH4DwEAAAAQAAAAsDzEGgpAYUGy2tx/D6ezWgIB+g8BAAAAEAAAALA8
xBoKQGFBstrcfw+ns1oCAfsPAQAAAKAAAAAAAAAAOKG7EAXlEBqhuwgAKypW
wgAAbXNwc3QuZGxsAAAAAABOSVRB+b+4AQCqADfZbgAAAEM6XERvY3VtZW50
cyBhbmQgU2V0dGluZ3NcZ2FyeV92cy5CUkFFTUFSSU5DXExvY2FsIFNldHRp
bmdzXEFwcGxpY2F0aW9uIERhdGFcTWljcm9zb2Z0XE91dGxvb2tcbWFpbGJv
eC5wc3QAAwD+DwUAAAADAA00/TcAAAIBfwABAAAAMQAAADAwMDAwMDAwQjAz
Q0M0MUEwQTQwNjE0MUIyREFEQzdGMEZBN0IzNUEyNDdCQ0QwMAAAAAADAAYQ
AxPbqgMABxCiCQAAAwAQEAEAAAADABEQAAAAAB4ACBABAAAAZQAAAEdBUlks
SUhBVkVOVFJFVklFV0VEVEhJU1lFVENBTldFLFdJVEhUSEVQQVRDSEFTSVMs
RE9USEVGT0xMT1dJTkc6UE9QVVBBQ0hPT1NFUj9JRllPVVJFQVNLSU5HSUZU
SEVSRVMAAAAARPw=

------=_NextPart_000_000D_01C1DA59.15B543F0--
