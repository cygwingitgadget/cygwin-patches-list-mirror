Return-Path: <cygwin-patches-return-2923-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2245 invoked by alias); 3 Sep 2002 13:46:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2229 invoked from network); 3 Sep 2002 13:46:57 -0000
Message-ID: <3D74BD4A.80403@netscape.net>
Date: Tue, 03 Sep 2002 06:46:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
References: <20020830142028.F5475@cygbert.vinschen.de> <97179922214.20020830163339@logos-m.ru> <20020830150147.G5475@cygbert.vinschen.de> <110182341242.20020830171358@logos-m.ru> <s1selceuumv.fsf@jaist.ac.jp> <3D720D1F.37080487@yahoo.com> <s1sbs7hvijp.fsf@jaist.ac.jp> <20020903142809.B12899@cygbert.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q3/txt/msg00371.txt.bz2

Corinna Vinschen wrote:

>>2002-09-02  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>>
>>  * cygwin.din: Revert exporting new wchar functions.
>>  * include/cygwin/version.h: Revert bumping API minor number.
>>
>
>Applied with a little tweak in version.h.
>
I'd like to voice a small objection to this practice of adding and then 
removing symbols, especially given the quantity in this case and the 
period of time which lapsed inbetween.  I don't think this practice 
should be encouraged at all because it can be quite a PITA if you have 
apps which were compiled when the symbols were exported.  I think this 
goes double for "cosmetic" issues which are going to be fixed anyhow in 
the near future.  I'm trying to help Conrad test the cygserver, so I 
have many apps I'm using for testing purposes.  I am now going to have 
to recompile the ones I just compiled the other day due to this change. 
 Chuck once told me, and I agree, that once symbols are added then they 
should not be removed [unless this is done in a very short period of 
time, like a matter of hours].  Any problems which arise with the 
exported function will have to be fixed in due course of time, but the 
export should remain.  Now I realize these are cvs/snapshot sources, but 
some considieration should be given to the consistancy of the dll.  As 
Chuck said, we shouldn't just add[remove] symbols in a willy-nilly 
fashion.  At the very least, if removing the functions *had* to be done, 
you could have left dummy stubs in place until the real functions were 
ready to go.  I guess this is just my 2¢ chiming in on this, so feel 
free to disagree...

Cheers,
Nicholas
