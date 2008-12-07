Return-Path: <cygwin-patches-return-6375-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31590 invoked by alias); 7 Dec 2008 19:04:21 -0000
Received: (qmail 31577 invoked by uid 22791); 7 Dec 2008 19:04:21 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout01.t-online.de (HELO mailout01.t-online.de) (194.25.134.80)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 07 Dec 2008 19:03:44 +0000
Received: from fwd01.aul.t-online.de  	by mailout01.t-online.de with smtp  	id 1L9Our-0004as-00; Sun, 07 Dec 2008 20:03:41 +0100
Received: from [10.3.2.2] (rXO14+ZCYhIkMKG33nTKz9HS0GPsg2K5WP-OwnSsU+jDbhN-v94a+u9KOK+gwY0w13@[217.235.206.63]) by fwd01.aul.t-online.de 	with esmtp id 1L9OuU-1LiqDw0; Sun, 7 Dec 2008 20:03:18 +0100
Message-ID: <493C1DF7.6090905@t-online.de>
Date: Sun, 07 Dec 2008 19:04:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash   find)
References: <49384250.7080707@t-online.de> <20081205095742.GP12905@calimero.vinschen.de> <4939A9F7.1000400@t-online.de> <20081207171802.GV12905@calimero.vinschen.de>
In-Reply-To: <20081207171802.GV12905@calimero.vinschen.de>
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
X-SW-Source: 2008-q4/txt/msg00019.txt.bz2

Hi Corinna,

Corinna Vinschen wrote:
> ...
>> With the attached patch, a duplicate name "foo" is handled as follows:
>>
>> - readdir() returns the key as "foo" and the value as "foo%val".
>> - If the name is "foo%val", stat() and open() consider only the value 
>> "foo".
>>
>> This keeps the names 'as is' if possible and allows access to the (very 
>> few) entries with duplicate names. The "%val" is at least somewhat 
>> self-explanatory.
>>     
>
> Cool.  Can you please send a ChangeLog entry as well?
>
>   

Of course:

2008-12-07  Christian Franke  <franke@computer.org>

	* fhandler_registry.cc (encode_regname): Add Parameter add_val.
	Append "%val" if add_val is set.
	(decode_regname): Remove trailing "%val". Change returncode
	accordingly.
	(__DIR_hash): New class.
	(d_hash): New macro.
	(key_exists): New function.
	(fhandler_registry::exists): Remove encode of registry name
	before path compare, decode file part of path instead.
	Skip checks for keys if trailing "%val" detected.
	(fhandler_registry::fstat): Change check of return
	value of decode_regname ().
	(fhandler_registry::readdir): Allocate __DIR_hash.
	Record key names in hash table. Append "%val" if key with
	same name exists. Fix error handling of encode_regname ().
	Set dirent.d_type.
	(fhandler_registry::closedir): Delete __DIR_hash.
	(fhandler_registry::open): Don't open key if trailing "%val"
	detected by decode_regname ().
	(open_key): Ditto.



Christian
