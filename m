Return-Path: <cygwin-patches-return-6399-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6326 invoked by alias); 19 Dec 2008 17:36:53 -0000
Received: (qmail 6312 invoked by uid 22791); 19 Dec 2008 17:36:52 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mailout10.t-online.de (HELO mailout10.t-online.de) (194.25.134.21)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 19 Dec 2008 17:36:09 +0000
Received: from fwd05.aul.t-online.de  	by mailout10.sul.t-online.de with smtp  	id 1LDjGg-0001vD-01; Fri, 19 Dec 2008 18:36:06 +0100
Received: from [10.3.2.2] (TbzcumZU8hQXZSKiirfHswjlC-Onc+fczGBuTTrQxscun+aX5qYQCIRro4UVb3MgOf@[217.235.211.52]) by fwd05.aul.t-online.de 	with esmtp id 1LDjGU-0LE44O0; Fri, 19 Dec 2008 18:35:54 +0100
Message-ID: <494BDB7A.4000103@t-online.de>
Date: Fri, 19 Dec 2008 17:36:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow access to /proc/registry/HKEY_PERFORMANCE_DATA
References: <494BA890.8000004@t-online.de> 	 <2ce9650b0812190705v520e1be1h779e88196c942b9d@mail.gmail.com> <2ce9650b0812190727i5dcfcee9h3398b6140e475431@mail.gmail.com>
In-Reply-To: <2ce9650b0812190727i5dcfcee9h3398b6140e475431@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00043.txt.bz2

Chris January wrote:
> On Fri, Dec 19, 2008 at 1:58 PM, Christian Franke  wrote:
>   
>>        (fhandler_registry::fill_filebuf): Use larger buffer to speed up
>>        access to HKEY_PERFORMANCE_DATA values.  Remove check for possible
>>        subkey.  Add RegCloseKey ().
>>     
>
> +      /* RegQueryValueEx () opens HKEY_PERFORMANCE_DATA.  */
> +      RegCloseKey (handle);
>
> I'm slightly puzzled by this change. handle is usually closed in
> fhandler_register::close. If you close it here then won't CloseHandle
> be called with an invalid handle in that method?
>
>   

fhandler_registry::close() closes only handles < HKEY_CLASSES_ROOT. 
Normally, it is not necessary to close predefined keys.

HKEY_PERFORMANCE_DATA is an exception: It has no subkeys and access to a 
value opens the predefined key. Therefore, the key is closed immediately 
after value access. Doing this in close() would require to pass a new 
'key_is_open' flag from fill_filebuf().

Christian
