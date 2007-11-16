Return-Path: <cygwin-patches-return-6171-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1003 invoked by alias); 16 Nov 2007 20:49:51 -0000
Received: (qmail 993 invoked by uid 22791); 16 Nov 2007 20:49:51 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout07.sul.t-online.de (HELO mailout07.sul.t-online.com) (194.25.134.83)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 16 Nov 2007 20:49:47 +0000
Received: from fwd34.aul.t-online.de  	by mailout07.sul.t-online.com with smtp  	id 1It88G-0001D8-01; Fri, 16 Nov 2007 21:49:44 +0100
Received: from [10.3.2.2] (EALdCeZfQh879zIz0VuWIqbUDu7jjfn1RH89c-BtAsAVZDbTgXHlQ43EC3KU3tWZA7@[217.235.208.193]) by fwd34.aul.t-online.de 	with esmtp id 1It886-02mxlI0; Fri, 16 Nov 2007 21:49:34 +0100
Message-ID: <473E0262.8090203@t-online.de>
Date: Fri, 16 Nov 2007 20:49:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] Encode invalid chars in /proc/registry entries
References: <473CC0A6.6010409@t-online.de> <20071116110901.GK30894@calimero.vinschen.de> <20071116134022.GA7993@ednor.casa.cgf.cx> <473DF114.1090108@t-online.de> <20071116194229.GA9171@ednor.casa.cgf.cx>
In-Reply-To: <20071116194229.GA9171@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: EALdCeZfQh879zIz0VuWIqbUDu7jjfn1RH89c-BtAsAVZDbTgXHlQ43EC3KU3tWZA7
X-TOI-MSGID: 73680a6b-8042-4035-9a31-f2c9573a9f5f
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00023.txt.bz2

Christopher Faylor wrote:
> On Fri, Nov 16, 2007 at 08:35:48PM +0100, Christian Franke wrote:
>   
>> Christopher Faylor wrote:
>>     
>>> ..
>>>       
>>>>> Patch is tested with 1.5.24-2. Merge with HEAD looks good, but was not 
>>>>> actually tested. Therefore, no changelog provided yet.
>>>>>       
>>>>>           
>>>> Thanks for this patch.  Apart from the missing ChangeLog I'm inclined
>>>> to apply it to the upcoming 1.5.25 release, but I don't like to have it
>>>> in HEAD as is.
>>>>     
>>>>         
>>> I'm not so sure it's appropriate for either yet.
>>>
>>> Isn't it possible to use at least some of the managed mode functions
>>> which deal with munging characters to do some of encoding?  It seems
>>> like the patch duplicates some of the functionality from path.cc.
>>>
>>> I realize that the registry is sort of the opposite of a managed mount
>>> but it seems like the encoding functions might be potentially used in
>>> reverse for this.
>>>       
>> I actually consulted path.cc before starting the patch but did not find
>> any function which provides the required functionality OOTB.
>> Therefore, I solved the tradeoff between "reuse" and "do not change
>> working code if you don't have time for thorough regression testing" by
>> the latter :-)
>>     
>
> I'm sorry but "reuse" is a fairly important concept in a project like
> this.  

Agree. But there is always this tradeoff when fixing bugs.


> The proc functions, in particular, have been prone to NIH and I
> don't want to see even more there if we can possibly help it.
>
>   

> So, I'll reiterate my suggestion that you look at, e.g.,
> mount_item::fnmunge and possibly think about generalizing it if it isn't
> quite up to the task.
>
>   

OK, I will do this for a possible HEAD patch. But not for this patch, 
due to increased regression risk.

fnmunge() is different: The chars '/' and '\' are not considered special 
but special names are handled.
The inverse fnunmunge() decodes each %XX sequence, which I didn't want 
to avoid introducing alias names.


> I'll also go on record as advocating that this not be part of a bugfix
> release.  It seems too much like a last minute change to me.
>
>   

Sorry, but I disagree. My patch does not introduce a nice-to-have 
feature. Returning non-POSIX conforming names in readdir() is IMO not a 
minor issue. And Cygwin adds the worst possible registry entry name 
("/") itself.

To be convinced, please try

$ find /proc/registry/HKEY_LOCAL_MACHINE/SOFTWARE/Cygnus\ Solutions 
 >some.file

(Own risk, it may result in a bluescreen on XP SP2)

This should be fixed in a bugfix release when a reasonable tested patch 
with low regression-risk is available (which is IMO the case now :-)


> Getting it into cvs main, however, seems like a good idea.
>
>   

Agree :-)


Christian
