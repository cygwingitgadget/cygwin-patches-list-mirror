Return-Path: <cygwin-patches-return-2813-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30007 invoked by alias); 8 Aug 2002 20:06:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29993 invoked from network); 8 Aug 2002 20:06:13 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 08 Aug 2002 13:06:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Add/remove program options [Was Re: cygwin-ENV-Variable]
In-Reply-To: <20020804191816.GA12853@redhat.com>
Message-ID: <Pine.GSO.4.44.0208081556280.8607-200000@slinky.cs.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-342241519-1028837173=:8607"
X-SW-Source: 2002-q3/txt/msg00261.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-342241519-1028837173=:8607
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 2240

On Sun, 4 Aug 2002, Christopher Faylor wrote:

> On Sun, Aug 04, 2002 at 09:01:26PM +0200, Sven K?hler wrote:
> >i realized that enigmail doesn't pass the CYGWIN-Variable to gpg when
> >executing. could you imagine chaning the ENV-Variable into a Reg-Key!?
>
> There is already an undocumented way to do this in cygwin via the
> Program Options registry key.  Create a new key:
>
> HKLM\SOFTWARE\Cygnus Solutions\Cygwin\Program Options
>
> under this, you can create an string entry named "default" with data
> containing CYGWIN environment variable options.  If you add an "export"
> option to the end of the data values, a CYGWIN environment variable will
> be regenerated from the registry and visible in the environment.
>
> You can also set options for individual programs by adding an entry like:
>
> Name                    Type            Data
> c:\usr\sbin\inetd.exe   REG_SZ          tty export
>
> That will make cygwin always set the cygwin option to tty and export
> a CYGWIN=tty for every program that inetd invokes.
>
> The main reason this this is not documented is that there is no
> programmatic way to manipulate it and I am not comfortable with telling
> people how to edit the registry "by hand".
>
> However, if you are familiar with the registry, then setting this value
> should not be a big deal.

Hi,
I've whipped up a small script (attached) to add and remove the values for
individual program options.  The script is named cygtweak (courtesy Robert
Collins), but should probably be renamed.  The help should be reasonably
comprehensive.

I'm not sure if this qualifies as a patch, but I think this got overlooked
on the cygwin mailing list, so I'm re-sending it here.  If this is a wrong
place for it, please let me know.  Where and how does one submit new
programs, anyway?  Do they need a ChangeLog entry?
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

It took the computational power of three Commodore 64s to fly to the moon.
It takes a 486 to run Windows 95.  Something is wrong here. -- SC sig file


---559023410-342241519-1028837173=:8607
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=cygtweak
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0208081606130.8607@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename=cygtweak
Content-length: 6523

IyEvYmluL3NoDQojDQojIGN5Z3R3ZWFrIC0tIGFkZCBvciByZW1vdmUgcHJv
Z3JhbS1zcGVjaWZpYyB2YWx1ZXMgZm9yIHRoZSBDWUdXSU4NCiMgZW52aXJv
bm1lbnQgdmFyaWFibGUuDQojDQojIENvcHlyaWdodCAoYykgMjAwMiwgSWdv
ciBQZWNodGNoYW5za2kuDQojDQojIFlvdSBtYXkgZGlzdHJpYnV0ZSB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYw0KIyBMaWNl
bnNlLiAgDQojDQojIElnb3IgUGVjaHRjaGFuc2tpDQojIHBlY2h0Y2hhQGNz
Lm55dS5lZHUNCiMgRGVwYXJ0bWVudCBvZiBDb21wdXRlciBTY2llbmNlDQoj
IE5ldyBZb3JrIFVuaXZlcnNpdHkNCiMgTmV3IFlvcmssIE5ZICAxMDAwMw0K
Iw0KIyBjeWd0d2VhayB2MC4yDQojDQojIENoYW5nZXMgaW4gdjAuMjoNCiMg
CUZpeCAtLXZlcmJvc2UuDQojIAlGaXggdHlwbyBpbiB1c2FnZS4NCiMNCg0K
aWYgWyAiJDEiID0gZGVidWcgXTsgdGhlbg0KICAgIHNldCAteA0KICAgIHNo
aWZ0DQpmaQ0KDQpwcm9nbmFtZT1gYmFzZW5hbWUgJDBgDQp2ZXJzaW9uPScw
LjInDQoNClJFR1RPT0w9L3Vzci9iaW4vcmVndG9vbA0KUkVHS0VZPSIvSEtM
TS9TT0ZUV0FSRS9DeWdudXMgU29sdXRpb25zL0N5Z3dpbi9Qcm9ncmFtIE9w
dGlvbnMiDQoNCmlmIFsgISAteCAkUkVHVE9PTCBdOyB0aGVuDQogICAgZWNo
byAiJHByb2duYW1lOiBDYW4ndCBmaW5kICRSRUdUT09MLCBleGl0aW5nLiIg
MT4mMg0KICAgIGV4aXQgMQ0KZmkNCg0Kd2hpbGUgWyAkIyAtbmUgMCBdOyBk
bw0KICAgIGNhc2UgJDEgaW4NCiAgICAtdiB8IC0tdmVyYm9zZSkNCiAgICAg
ICAgICAgIHZlcmJvc2U9IllFUyIgOzsNCg0KICAgIC1uIHwgLS1ub2V4ZWMp
DQogICAgICAgICAgICB2ZXJib3NlPSJZRVMiDQogICAgICAgICAgICBub2V4
ZWM9IllFUyIgOzsNCg0KICAgIC1hIHwgLS1hZGQtcHJvZ3JhbS1vdmVycmlk
ZSkNCiAgICAgICAgICAgIGlmIFsgLW4gIiRhY3Rpb24iIF07IHRoZW4NCiAg
ICAgICAgICAgICAgICBlY2hvICIkcHJvZ25hbWU6IFBsZWFzZSBzcGVjaWZ5
IG9ubHkgb25lIGFjdGlvbi4iIDE+JjINCiAgICAgICAgICAgICAgICBleGl0
IDANCiAgICAgICAgICAgIGZpDQogICAgICAgICAgICBhY3Rpb249IkFERCIN
CiAgICAgICAgICAgIHByb2dyYW09IiQyIg0KICAgICAgICAgICAgY3lnd2lu
PSIkMyINCiAgICAgICAgICAgIHNoaWZ0DQogICAgICAgICAgICBzaGlmdDs7
DQoNCiAgICAtciB8IC0tcmVtb3ZlLXByb2dyYW0tb3ZlcnJpZGUpDQogICAg
ICAgICAgICBpZiBbIC1uICIkYWN0aW9uIiBdOyB0aGVuDQogICAgICAgICAg
ICAgICAgZWNobyAiJHByb2duYW1lOiBQbGVhc2Ugc3BlY2lmeSBvbmx5IG9u
ZSBhY3Rpb24uIiAxPiYyDQogICAgICAgICAgICAgICAgZXhpdCAwDQogICAg
ICAgICAgICBmaQ0KICAgICAgICAgICAgYWN0aW9uPSJSRU1PVkUiDQogICAg
ICAgICAgICBwcm9ncmFtPSIkMiINCiAgICAgICAgICAgIHNoaWZ0OzsNCg0K
ICAgIC1lIHwgLS1leHBvcnQpDQogICAgICAgICAgICBpZiBbIC16ICIkYWN0
aW9uIiBdOyB0aGVuDQogICAgICAgICAgICAgICAgZWNobyAiJHByb2duYW1l
OiBQbGVhc2Ugc3BlY2lmeSBhbiBhY3Rpb24gZmlyc3QuIiAxPiYyDQogICAg
ICAgICAgICBlbGlmIFsgIiRhY3Rpb24iICE9IEFERCBdOyB0aGVuDQogICAg
ICAgICAgICAgICAgZWNobyAiJHByb2duYW1lOiBXYXJuaW5nOiAtZSBpZ25v
cmVkIGZvciAtci4iIDE+JjINCiAgICAgICAgICAgIGVsc2UNCiAgICAgICAg
ICAgICAgICBleHBvcnQ9IllFUyINCiAgICAgICAgICAgIGZpOzsNCg0KICAg
IC1WIHwgLT92ZXJzaW9uKQ0KICAgICAgICAgICAgZWNobyAkcHJvZ25hbWU6
IHZlcnNpb24gJHZlcnNpb24gMT4mMg0KICAgICAgICAgICAgZXhpdCAwIDs7
DQoNCiAgICAtaCB8IC0/aGVscCkNCiAgICAgICAgICAgIGVjaG8gIlVzYWdl
OiAkcHJvZ25hbWUgWy12fC1uXSBhY3Rpb24gYWN0aW9uLXNwZWNpZmljLXBh
cmFtcyIgMT4mMg0KICAgICAgICAgICAgZWNobyAiICB3aGVyZSBhY3Rpb24g
aXMgb25lIG9mIiAxPiYyDQogICAgICAgICAgICBlY2hvICIgICAgLWF8LS1h
ZGQtcHJvZ3JhbS1vdmVycmlkZSBwcm9ncmFtIFwkQ1lHV0lOLXZhbHVlIFst
ZXwtLWV4cG9ydF0iIDE+JjINCiAgICAgICAgICAgIGVjaG8gIiAgICAgICAg
ICAgICAgYWRkcyBhbiBvdmVycmlkZSBmb3IgdGhlIHZhbHVlIG9mIHRoZSBD
WUdXSU4gdmFyaWFibGUiIDE+JjINCiAgICAgICAgICAgIGVjaG8gIiAgICAg
ICAgICAgICAgd2hlbiBpbnZva2luZyB0aGUgcHJvZ3JhbSIgMT4mMg0KICAg
ICAgICAgICAgZWNobyAiICAgICAgICAgICAgICAtLWV4cG9ydCBleHBvcnRz
IHRoZSB2YWx1ZSB0byBhbGwgY2hpbGRyZW4gb2YgdGhlIGdpdmVuIHByb2dy
YW0iIDE+JjINCiAgICAgICAgICAgIGVjaG8gIiAgICAtcnwtLXJlbW92ZS1w
cm9ncmFtLW92ZXJyaWRlIHByb2dyYW0iIDE+JjINCiAgICAgICAgICAgIGVj
aG8gIiAgICAgICAgICAgICAgcmVtb3ZlcyBhbiBvdmVycmlkZSBmb3IgYSBn
aXZlbiBwcm9ncmFtIiAxPiYyDQogICAgICAgICAgICBlY2hvIDE+JjINCiAg
ICAgICAgICAgIGVjaG8gIklmIC0tdmVyYm9zZSBvciAtdiBpcyBzcGVjaWZp
ZWQsIHRoZSByZWdpc3RyeSBtb2RpZmljYXRpb24gYWN0aW9ucyBhcmUgcHJp
bnRlZCIgMT4mMg0KICAgICAgICAgICAgZWNobyAiSWYgLS1ub2V4ZWMgb3Ig
LW4gaXMgc3BlY2lmaWVkLCBubyBjb21tYW5kcyB0aGF0IGNoYW5nZSB0aGUg
cmVnaXN0cnkgd2lsbCBiZSBydW4iIDE+JjINCiAgICAgICAgICAgIGVjaG8g
IiAgTm90ZSB0aGF0IC0tbm9leGVjIGltcGxpZXMgLS12ZXJib3NlIiAxPiYy
DQogICAgICAgICAgICBlY2hvIDE+JjINCiAgICAgICAgICAgIGVjaG8gIkV4
YW1wbGVzOiAkcHJvZ25hbWUgLXYgLS1hZGQtcHJvZ3JhbS1vdmVycmlkZSAv
dXNyL3NiaW4vaW5ldGQgJ3R0eScgLS1leHBvcnQiIDE+JjINCiAgICAgICAg
ICAgIGVjaG8gIiAgICAgICAgICAkcHJvZ25hbWUgLS1yZW1vdmUtcHJvZ3Jh
bS1vdmVycmlkZSAvdXNyL3NiaW4vc3NoZCIgMT4mMg0KICAgICAgICAgICAg
ZXhpdCAwIDs7DQoNCiAgICAqKQ0KICAgICAgICAgICAgZWNobyAiJHByb2du
YW1lOiBJbnZhbGlkIGFyZ3VtZW50KHMpLiIgMT4mMg0KICAgICAgICAgICAg
ZWNobyAiVHJ5ICckcHJvZ25hbWUgLS1oZWxwJyBmb3IgbW9yZSBpbmZvcm1h
dGlvbi4iIDE+JjINCiAgICAgICAgICAgIGV4aXQgMSA7Ow0KICAgIGVzYWMN
CiAgICBzaGlmdA0KZG9uZQ0KDQppZiBbIC16ICIkYWN0aW9uIiBdOyB0aGVu
DQogICAgZWNobyAiJHByb2duYW1lOiBNaXNzaW5nIGFyZ3VtZW50KHMpLiIg
MT4mMg0KICAgIGVjaG8gIlRyeSAnJHByb2duYW1lIC0taGVscCcgZm9yIG1v
cmUgaW5mb3JtYXRpb24uIiAxPiYyDQogICAgZXhpdCAxDQpmaQ0KDQpjYXNl
ICRwcm9ncmFtIGluDQovKikgcHJvZ3JhbT1gY3lncGF0aCAtdyAiJHByb2dy
YW0iIHwgc2VkICdzL1xcXFwvXFxcXFxcXFwvZydgIDs7DQplc2FjDQoNCmNh
c2UgJGFjdGlvbiBpbg0KQUREKQ0KICAgICAgICAjIEZpcnN0IGNoZWNrIGlm
IHRoZSBrZXkgZXhpc3RzDQogICAgICAgIGlmICEgJFJFR1RPT0wgLXEgY2hl
Y2sgIiRSRUdLRVkiOyB0aGVuDQogICAgICAgICAgICBpZiBbIC1uICIkdmVy
Ym9zZSIgXTsgdGhlbg0KICAgICAgICAgICAgICAgIGVjaG8gIiRwcm9nbmFt
ZTogXCIkUkVHS0VZXCIgbm90IGZvdW5kLCBhZGRpbmcuIg0KICAgICAgICAg
ICAgZmkNCiAgICAgICAgICAgIGlmIFsgLXogIiRub2V4ZWMiIF07IHRoZW4N
CiAgICAgICAgICAgICAgICAkUkVHVE9PTCBhZGQgIiRSRUdLRVkiDQogICAg
ICAgICAgICBlbHNlDQogICAgICAgICAgICAgICAgZWNobyAiJFJFR1RPT0wg
YWRkIFwiJFJFR0tFWVwiIg0KICAgICAgICAgICAgZmkNCiAgICAgICAgZmkN
CiAgICAgICAgIyBUYWNrIG9uICJleHBvcnQiIGlmIG5lZWRlZA0KICAgICAg
ICBpZiBbIC1uICIkZXhwb3J0IiBdOyB0aGVuDQogICAgICAgICAgICBjeWd3
aW49IiRjeWd3aW4gZXhwb3J0Ig0KICAgICAgICBmaQ0KICAgICAgICAjIE5v
dyBhZGQgdGhlIGNvcnJlc3BvbmRpbmcgdmFsdWUNCiAgICAgICAgaWYgWyAt
biAiJHZlcmJvc2UiIF07IHRoZW4NCiAgICAgICAgICAgIGVjaG8gIiRwcm9n
bmFtZTogU2V0dGluZyBcIiRSRUdLRVkvJHByb2dyYW1cIiB0byBcIiRjeWd3
aW5cIi4iDQogICAgICAgIGZpDQogICAgICAgIGlmIFsgLXogIiRub2V4ZWMi
IF07IHRoZW4NCiAgICAgICAgICAgICRSRUdUT09MIC1LQCAtcyBzZXQgIiRS
RUdLRVlAJHByb2dyYW0iICIkY3lnd2luIg0KICAgICAgICAgICAgZXhpdCAk
Pw0KICAgICAgICBlbHNlDQogICAgICAgICAgICBlY2hvICIkUkVHVE9PTCAt
S0AgLXMgc2V0IFwiJFJFR0tFWUAkcHJvZ3JhbVwiIFwiJGN5Z3dpblwiIg0K
ICAgICAgICBmaQ0KICAgICAgICA7Ow0KDQpSRU1PVkUpDQogICAgICAgICMg
UmVtb3ZlIHRoZSBjb3JyZXNwb25kaW5nIHZhbHVlDQogICAgICAgIGlmIFsg
LW4gIiR2ZXJib3NlIiBdOyB0aGVuDQogICAgICAgICAgICBlY2hvICIkcHJv
Z25hbWU6IFJlbW92aW5nIFwiJFJFR0tFWS8kcHJvZ3JhbVwiLiINCiAgICAg
ICAgZmkNCiAgICAgICAgaWYgWyAteiAiJG5vZXhlYyIgXTsgdGhlbg0KICAg
ICAgICAgICAgJFJFR1RPT0wgLUtAIHVuc2V0ICIkUkVHS0VZQCRwcm9ncmFt
Ig0KICAgICAgICAgICAgZXhpdCAkPw0KICAgICAgICBlbHNlDQogICAgICAg
ICAgICBlY2hvICIkUkVHVE9PTCAtS0AgdW5zZXQgXCIkUkVHS0VZQCRwcm9n
cmFtXCIiDQogICAgICAgIGZpDQogICAgICAgIDs7DQplc2FjDQoNCg==

---559023410-342241519-1028837173=:8607--
