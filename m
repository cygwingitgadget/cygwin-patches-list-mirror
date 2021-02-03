Return-Path: <ben@wijen.net>
Received: from 17.mo5.mail-out.ovh.net (17.mo5.mail-out.ovh.net
 [46.105.56.132])
 by sourceware.org (Postfix) with ESMTPS id 3A440385800E
 for <cygwin-patches@cygwin.com>; Wed,  3 Feb 2021 11:03:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3A440385800E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player778.ha.ovh.net (unknown [10.108.54.119])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 8D0272AEEBE
 for <cygwin-patches@cygwin.com>; Wed,  3 Feb 2021 12:03:17 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 8D9191AB7ADEF
 for <cygwin-patches@cygwin.com>; Wed,  3 Feb 2021 11:03:13 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00584898515-3238-4088-b1be-f53277de4f6f,
 34B4DD6D8321AE596D2C59DB52D829039CC1F096) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben <ben@wijen.net>
Subject: Re: [PATCH v2 4/8] syscalls.cc: Implement non-path_conv dependent
 _unlink_nt
To: Corinna Vinschen via Cygwin-patches <cygwin-patches@cygwin.com>
References: <20210115134534.13290-1-ben@wijen.net>
 <20210120161056.77784-5-ben@wijen.net>
 <20210126113441.GK4393@calimero.vinschen.de>
Message-ID: <9868efcd-3e70-fcbf-ba60-33ad9a5a6f3c@wijen.net>
Date: Wed, 3 Feb 2021 12:03:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210126113441.GK4393@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9436167123236833028
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrgedvgddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhuffvfhfkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepteeijefhvdehkefgfeevgeffleeijeelgefguefgheffffetteeijedvgfekieefnecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 03 Feb 2021 11:03:21 -0000



On 26-01-2021 12:34, Corinna Vinschen via Cygwin-patches wrote:
> 
> First of all, the new function should better get a new name.  The _nt
> postfix is pretty much historical anyway to differentiate between the
> function using Win32 API and the function using NT API.  This is kind
> of moot these days sine we're using the NT API almost exclusively for
> file access anyway.
> 
> So stick to unlink_nt/_unlink_nt for the existing functions, and name
> the new function accorind to it's  doings, like, say, unlink_path or
> whatever.
> 
Sure, I will rename them.


>> +  static bool has_posix_unlink_semantics =
>> +      wincap.has_posix_unlink_semantics ();
>> +  static bool has_posix_unlink_semantics_with_ignore_readonly =
>> +      wincap.has_posix_unlink_semantics_with_ignore_readonly ();
> 
> Did you mean `const' rather than `static', by any chance?  Either way, I
> don't think these local vars are required, given that the wincap
> accessors are already marked as const.  The compiler should know how to
> opimize this sufficiently.
> 
I do mean static.
With each instantiation these are initialized to the wincap value.
Then later on, we might disable the behavior if we encounter a driver
which returns: STATUS_INVALID_PARAMETER

Assuming most files will reside on the same fs, (ie through the same driver)
this will save use from the system call which we know isn't supported.


>> +
>> +  HANDLE fh;
>> +  ACCESS_MASK access = DELETE;
>> +  IO_STATUS_BLOCK io;
>> +  ULONG flags = FILE_OPEN_REPARSE_POINT | FILE_OPEN_FOR_BACKUP_INTENT
>> +      | FILE_DELETE_ON_CLOSE | eflags;
> 
> This looks like a dangerous assumption.  So far we don't open unknown
> reparse points as reparse points deliberately.  No one knows what a
> unknown reparse point is good for or supposed to do, so we don't even
> know if we are allowed to handle it analogue to a symlink.
> 
When opening these, you are correct.
However, when a request is made to delete a reparse point, it's safe
- even for an unknown reparse point - to assume that it is the reparse point
itself which is to be deleted. Ofcourse: That's my theory.


> Consequentially we open unknown reparse points just as normal files, so
> that the reparse point's automatisms may kick in.  By omitting this
> step, we're moving on thin ice.
> 
This would mean an unknown reparse point can never be deleted.
I'm just not sure if that's what we should want.


>> +    {
>> +      //Step 2
>> +      //Reopen with all sharing flags, will set delete flag ourselves.
>> +      access |= FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES;
>> +      flags &= ~FILE_DELETE_ON_CLOSE;
>> +      fstatus = NtOpenFile (&fh, access, attr, &io, FILE_SHARE_VALID_FLAGS, flags);
>> +      debug_printf ("NtOpenFile %S: %y", attr->ObjectName, fstatus);
>> +
>> +      if (NT_SUCCESS (fstatus))
>> +        {
>> +          if (has_posix_unlink_semantics_with_ignore_readonly)
>> +            {
>> +              //Step 3
>> +              //Remove the file with POSIX unlink semantics, ignore readonly flags.
> 
> No check for NTFS?  Posix semantics are not supported on any other FS.
> No check for remote?  Just because you support POSIX semantics on
> *this* machine, doesn't mean the remote machine supports it at all...
> 
Indeed no checks.
If the driver correctly returns STATUS_INVALID_PARAMETER we will not try again (by
resetting the has_posix_unlink_semantics_with_ignore_readonly flag and then fallback to
usual trickery. If the driver returns error (but not STATUS_INVALID_PARAMETER) that
driver pays a single kernel call, which I deem acceptable.


>> +              FILE_DISPOSITION_INFORMATION_EX fdie =
>> +                { FILE_DISPOSITION_DELETE | FILE_DISPOSITION_POSIX_SEMANTICS
>> +                    | FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE };
>> +              istatus = NtSetInformationFile (fh, &io, &fdie, sizeof fdie,
>> +                                              FileDispositionInformationEx);
>> +              debug_printf ("NtSetInformation %S: %y", attr->ObjectName, istatus);
>> +
>> +              if(istatus == STATUS_INVALID_PARAMETER)
>> +                has_posix_unlink_semantics_with_ignore_readonly = false;
>> +            }
>> +
>> +          if (!has_posix_unlink_semantics_with_ignore_readonly
>> +              || !NT_SUCCESS (istatus))
>> +            {
>> +              //Step 4
>> +              //Check if we must clear the READONLY flag
>> +              FILE_BASIC_INFORMATION qfbi = { 0 };
>> +              istatus = NtQueryInformationFile (fh, &io, &qfbi, sizeof qfbi,
>> +                                                FileBasicInformation);
>> +              debug_printf ("NtQueryFileBasicInformation %S: %y",
>> +                            attr->ObjectName, istatus);
>> +
>> +              if (NT_SUCCESS (istatus))
>> +                {
>> +                  if (qfbi.FileAttributes & FILE_ATTRIBUTE_READONLY)
>> +                    {
>> +                      //Step 5
>> +                      //Remove the readonly flag
>> +                      FILE_BASIC_INFORMATION sfbi = { 0 };
>> +                      sfbi.FileAttributes = FILE_ATTRIBUTE_ARCHIVE;
>> +                      istatus = NtSetInformationFile (fh, &io, &sfbi,
>> +                                                      sizeof sfbi,
>> +                                                      FileBasicInformation);
>> +                      debug_printf ("NtSetFileBasicInformation %S: %y",
>> +                                    attr->ObjectName, istatus);
>> +                    }
>> +
>> +                  if (NT_SUCCESS (istatus))
>> +                    {
>> +                      //Step 6a
>> +                      //Now, mark the file ready for deletion
>> +                      if (has_posix_unlink_semantics)
>> +                        {
>> +                          FILE_DISPOSITION_INFORMATION_EX fdie =
>> +                            { FILE_DISPOSITION_DELETE
>> +                                | FILE_DISPOSITION_POSIX_SEMANTICS };
>> +                          istatus = NtSetInformationFile (
>> +                              fh, &io, &fdie, sizeof fdie,
>> +                              FileDispositionInformationEx);
>> +                          debug_printf (
>> +                              "NtSetFileDispositionInformationEx %S: %y",
>> +                              attr->ObjectName, istatus);
>> +
>> +                          if (istatus == STATUS_INVALID_PARAMETER)
>> +                            has_posix_unlink_semantics = false;
>> +                        }
>> +
>> +                      if (!has_posix_unlink_semantics
>> +                          || !NT_SUCCESS (istatus))
>> +                        {
>> +                          //Step 6b
>> +                          //This will remove a readonly file (as we have just cleared that flag)
>> +                          //As we don't have posix unlink semantics, this will still fail if the file is in use.
> 
> Without transaction?
> 
Well, yes, the transaction overhead doesn't weigh up to the unlikeliness of failure, I think.
Because even if the delete fails, the attributes are restored. Or, very-unlikely-worst-case-scenario:
Both fail and we're left with a file with FILE_ATTRIBUTE_ARCHIVE which means the file has been marked for deletion.


>> +static NTSTATUS
>> +_unlink_ntpc_ (path_conv& pc, bool shareable)
> 
> The trailing underscore should be replaced with a descriptive postfix.

What about naming this function _unlink_nt and the original _unlink_nt, _unlink_fallback?


>> +{
>> +  OBJECT_ATTRIBUTES attr;
>> +  ULONG eflags = pc.isdir () ? FILE_DIRECTORY_FILE : FILE_NON_DIRECTORY_FILE;
>> +
>> +  pc.get_object_attr (attr, sec_none_nih);
>> +  NTSTATUS status = _unlink_nt (&attr, eflags);
> 
> Sorry, but I don't grok that.  You already have a path_conv, so what's
> the advantage of calling the unlink version without path_conv and thus,
> without certain check, like the reparse point check, or checks for
> filesystems with quirks, like MVFS?  What about remote filesystems of
> which you don't know nothing, e. g., a Win7 NTFS?  Did you check the
> error codes in this case?
> 
The idea is to - eventually - replace/incorporate the fallback unlink_nt.
But, because I indeed don't know the quirks of all filesystems, I left the fallback scenario intact, for now.
No, I have not checked all error codes, I simply don't have all filesystems at my disposal, again the reason for keeping the fallback.

The general idea is to forgo path_conv's filesystem checks and just try to delete the file,
if it fails, remember and fallback. After these series of commits, some will follow
to try and see if we can remove/incorporate the fallback scenario completely.


Ben...
