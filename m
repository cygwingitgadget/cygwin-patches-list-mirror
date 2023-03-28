Return-Path: <SRS0=3qoS=7U=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-048.btinternet.com (mailomta25-re.btinternet.com [213.120.69.118])
	by sourceware.org (Postfix) with ESMTPS id E54DF3858430
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 12:34:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E54DF3858430
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20230328123418.OPQC25570.re-prd-fep-048.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 28 Mar 2023 13:34:18 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 63FE98D2031F1F8B
X-Originating-IP: [81.153.98.128]
X-OWM-Source-IP: 81.153.98.128 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehgedghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeffkeeigfdujeehteduiefgjeeltdelgeelteekudetfedtffefhfeufefgueettdenucfkphepkedurdduheefrdelkedruddvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduheefrdelkedruddvkedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgvvhfkrfephhhoshhtkeduqdduheefqdelkedquddvkedrrhgrnhhgvgekuddqudehfedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhn
	thgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhstheprhgvqdhprhguqdhrghhouhhtqddttdef
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.153.98.128) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 63FE98D2031F1F8B; Tue, 28 Mar 2023 13:34:18 +0100
Message-ID: <2ef9176e-9282-d0d1-b047-d8555d4434da@dronecode.org.uk>
Date: Tue, 28 Mar 2023 13:34:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/3] Allow deriving the current user's home directory
 via the HOME variable
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
 cygwin-patches@cygwin.com
References: <cover.1663761086.git.johannes.schindelin@gmx.de>
 <cover.1679991274.git.johannes.schindelin@gmx.de>
 <7a074997ea64d9f9d6dab766d1c49627e762cbed.1679991274.git.johannes.schindelin@gmx.de>
 <ZCLC1kvfb5Gdk+Cd@calimero.vinschen.de>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZCLC1kvfb5Gdk+Cd@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1197.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 28/03/2023 11:35, Corinna Vinschen wrote:
> Apart from the doc change, the patch is ok now.

The preceding text says "Four schema are predefined, two schemata are 
variable", then we add "env" to both lists? That doesn't make much sense 
to me.  Surely it's just a "predefined schema"?  In any case that text 
should be updated.

> On Mar 28 10:17, Johannes Schindelin wrote:
>> diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
>> index c6871ecf05..1678ff6575 100644
>> --- a/winsup/doc/ntsec.xml
>> +++ b/winsup/doc/ntsec.xml
>> @@ -1203,6 +1203,17 @@ schemata are the following:
>>   	      See <xref linkend="ntsec-mapping-nsswitch-desc"></xref>
>>   	      for a more detailed description.</listitem>
>>     </varlistentry>
>> +  <varlistentry>
>> +    <term><literal>env</literal></term>
>> +    <listitem>Derives the home directory of the current user from the
>> +	      environment variable <literal>HOME</literal> (falling back to
>> +	      <literal>HOMEDRIVE\HOMEPATH</literal> and
>> +	      <literal>USERPROFILE</literal>, in that order).  This is faster
>> +	      than the <term><literal>windows</literal></term> schema at the
>> +	      expense of determining only the current user's home directory
>> +	      correctly.  This schema is skipped for any other account.
>> +	      </listitem>
>> +  </varlistentry>
>>   </variablelist>
> 
> I'd rephrase that a bit here.  This is the description of the scheme
> itself, so this should be something along the lines of "utilizes the
> current environment ..." and "Right now only valid for db_home, see xref
> linkend="ntsec-mapping-nsswitch-home"...
> 
> However, there's something strange going on, see below.
> 
>>   <para>
>> @@ -1335,6 +1346,17 @@ of each schema when used with <literal>db_home:</literal>
>>   	      See <xref linkend="ntsec-mapping-nsswitch-desc"></xref>
>>   	      for a detailed description.</listitem>
>>     </varlistentry>
>> +  <varlistentry>
>> +    <term><literal>env</literal></term>
>> +    <listitem>Derives the home directory of the current user from the
>> +	      environment variable <literal>HOME</literal> (falling back to
>> +	      <literal>HOMEDRIVE\HOMEPATH</literal> and
>> +	      <literal>USERPROFILE</literal>, in that order).  This is faster
>> +	      than the <term><literal>windows</literal></term> schema at the

I think drop wrapping in <term> here should fix the error below.  It's 
not valid docbook here.

>> +	      expense of determining only the current user's home directory
>> +	      correctly.  This schema is skipped for any other account.
>> +	      </listitem>
>> +  </varlistentry>
>>     <varlistentry>
>>       <term><literal>@ad_attribute</literal></term>
>>       <listitem>AD only: The user's home directory is set to the path given
> 
> There's something wrong here. Building the docs, I get these new error
> messages:
> 
>    docbook2texi://sect4[@id='ntsec-mapping-nsswitch-passwd']/variablelist[1]/varlistentry[5]/listitem/term: element not matched by any template
>    docbook2texi://sect4[@id='ntsec-mapping-nsswitch-home']/variablelist/varlistentry[5]/listitem/term: element not matched by any template
>    Element term in namespace '' encountered in listitem, but no template matches.
>    Element term in namespace '' encountered in listitem, but no template matches.
>    Element term in namespace '' encountered in listitem, but no template matches.
>    Element term in namespace '' encountered in listitem, but no template matches.
>    No template matches term in listitem.
>    No template matches term in listitem.
> 
> It looks like this has something to do with the <term> expression?
> 
> Jon, do you have an idea?


