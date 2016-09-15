require 'open3'

class PopulateMetasploitResult
  def initialize(file_path)
    @xml_doc = Nokogiri::XML(File.open(file_path))
  end
  
  def populate(user_id, engagement_id)

    generated_data = @xml_doc.xpath('//generated').first
    
    metasploit_report = MetasploitReport.new
    metasploit_report.time = generated_data['time'] rescue nil
    metasploit_report.metasploit_user = generated_data['user'] rescue nil
    metasploit_report.project = generated_data['project'] rescue nil
    metasploit_report.product = generated_data['product'] rescue nil
    metasploit_report.user_id = user_id
    metasploit_report.engagement_id = engagement_id
    metasploit_report.save
    
    hosts = @xml_doc.xpath('//host')
    
    hosts.each do |host|
      metasploit_host = metasploit_report.metasploit_hosts.new
      metasploit_host.metasploit_id = host.search('id')[0].content rescue nil
      metasploit_host.metasploit_created_at = host.search('created-at')[0].content rescue nil
      metasploit_host.address = host.search('address')[0].content rescue nil
      metasploit_host.mac = host.search('mac')[0].content rescue nil
      metasploit_host.comm = host.search('comm')[0].content rescue nil
      metasploit_host.name = host.search('name')[0].content rescue nil
      metasploit_host.state = host.search('state')[0].content rescue nil
      metasploit_host.os_name = host.search('os-name')[0].content rescue nil
      metasploit_host.os_flavor = host.search('os-flavor')[0].content rescue nil
      metasploit_host.os_sp = host.search('os-sp')[0].content rescue nil
      metasploit_host.os_lang = host.search('os-lang')[0].content rescue nil
      metasploit_host.arch = host.search('arch')[0].content rescue nil
      metasploit_host.workspace_id = host.search('workspace-id')[0].content rescue nil
      metasploit_host.metasploit_updated_at = host.search('updated-at')[0].content rescue nil
      metasploit_host.purpose = host.search('purpose')[0].content rescue nil
      metasploit_host.info = host.search('info')[0].content rescue nil
      metasploit_host.metasploit_scope = host.search('scope')[0].content rescue nil
      metasploit_host.note_count = host.search('note-count')[0].content rescue nil
      metasploit_host.vuln_count = host.search('vuln-count')[0].content rescue nil
      metasploit_host.service_count = host.search('service-count')[0].content rescue nil
      metasploit_host.host_detail_count = host.search('host-detail-count')[0].content rescue nil
      metasploit_host.exploit_attempt_count = host.search('exploit-attempt-count')[0].content rescue nil
      metasploit_host.cred_count = host.search('cred-count')[0].content rescue nil
      metasploit_host.history_count = host.search('history-count')[0].content rescue nil
      metasploit_host.detected_arch = host.search('detected-arch')[0].content rescue nil
      metasploit_host.comments = host.search('comments')[0].content rescue nil
      metasploit_host.virtual_host = host.search('virtual-host')[0].content rescue nil
      metasploit_host.save

      host.search('exploit_attempt').each do |exploit_attempt|
        metasploit_exploit_attempt = metasploit_host.metasploit_exploit_attempts.new
        metasploit_exploit_attempt.exploit_attempt_id = exploit_attempt.search('id')[0].content rescue nil
        metasploit_exploit_attempt.service_id = exploit_attempt.search('service-id')[0].content rescue nil
        metasploit_exploit_attempt.vuln_id = exploit_attempt.search('vuln-id')[0].content rescue nil
        metasploit_exploit_attempt.attempted_at = exploit_attempt.search('attempted-at')[0].content rescue nil
        metasploit_exploit_attempt.exploited = exploit_attempt.search('exploited')[0].content rescue nil
        metasploit_exploit_attempt.fail_reason = exploit_attempt.search('fail-reason')[0].content rescue nil
        metasploit_exploit_attempt.username = exploit_attempt.search('username')[0].content rescue nil
        metasploit_exploit_attempt.module = exploit_attempt.search('module')[0].content rescue nil
        metasploit_exploit_attempt.session_id = exploit_attempt.search('session-id')[0].content rescue nil
        metasploit_exploit_attempt.loot_id = exploit_attempt.search('loot-id')[0].content rescue nil
        metasploit_exploit_attempt.port = exploit_attempt.search('port')[0].content rescue nil
        metasploit_exploit_attempt.proto = exploit_attempt.search('proto')[0].content rescue nil
        metasploit_exploit_attempt.fail_detail = exploit_attempt.search('fail-detail')[0].content rescue nil
        metasploit_exploit_attempt.save

      end

      host.search('service').each do |service|
        metasploit_service = metasploit_host.metasploit_host_services.new
        metasploit_service.service_id = service.search('id')[0].content rescue nil
        metasploit_service.metasploit_created_at = service.search('created-at')[0].content rescue nil
        metasploit_service.metasploit_updated_at = service.search('updated-at')[0].content rescue nil
        metasploit_service.port = service.search('port')[0].content rescue nil
        metasploit_service.proto = service.search('proto')[0].content rescue nil
        metasploit_service.state = service.search('state')[0].content rescue nil
        metasploit_service.name = service.search('name')[0].content rescue nil
        metasploit_service.info = service.search('info')[0].content rescue nil
        metasploit_service.save
      end

      host.search('note').each do |note|
        metasploit_note = metasploit_host.metasploit_host_notes.new
        metasploit_note.note_id = note.search('id')[0].content rescue nil
        metasploit_note.metasploit_created_at = note.search('created-at')[0].content rescue nil
        metasploit_note.metasploit_updated_at = note.search('updated-at')[0].content rescue nil
        metasploit_note.ntype = note.search('ntype')[0].content rescue nil
        metasploit_note.workspace_id = note.search('workspace-id')[0].content rescue nil
        metasploit_note.service_id = note.search('service-id')[0].content rescue nil
        metasploit_note.critical = note.search('critical')[0].content rescue nil
        metasploit_note.seen = note.search('seen')[0].content rescue nil
        metasploit_note.data = note.search('data')[0].content rescue nil
        metasploit_note.vuln_id = note.search('vuln-id')[0].content rescue nil
        metasploit_note.save
      end

      host.search('vuln').each do |vuln|
        metasploit_host_vuln = metasploit_host.metasploit_host_vulns.new
        metasploit_host_vuln.vuln_id = vuln.search('id')[0].content rescue nil
        metasploit_host_vuln.service_id = vuln.search('service-id')[0].content rescue nil
        metasploit_host_vuln.metasploit_created_at = vuln.search('created-at')[0].content rescue nil
        metasploit_host_vuln.metasploit_updated_at = vuln.search('updated-at')[0].content rescue nil
        metasploit_host_vuln.info = vuln.search('info')[0].content rescue nil
        metasploit_host_vuln.exploited_at = vuln.search('exploited-at')[0].content rescue nil
        metasploit_host_vuln.vuln_detail_count = vuln.search('vuln-detail-count')[0].content rescue nil
        metasploit_host_vuln.vuln_attempt_count = vuln.search('vuln-attempt-count')[0].content rescue nil
        metasploit_host_vuln.nexpose_data_vuln_def_id = vuln.search('nexpose-data-vuln-def-id')[0].content rescue nil
        metasploit_host_vuln.origin_id = vuln.search('origin-id')[0].content rescue nil
        metasploit_host_vuln.origin_type = vuln.search('origin-type')[0].content rescue nil
        metasploit_host_vuln.notes = vuln.search('notes')[0].content rescue nil
        metasploit_host_vuln.vuln_details = vuln.search('vuln_details')[0].content rescue nil
        metasploit_host_vuln.vuln_attempts = vuln.search('vuln_attempts')[0].content rescue nil
        metasploit_host_vuln.name = vuln.search('name')[0].content rescue nil
        metasploit_host_vuln.save

        vuln.search('ref').each do |vuln_ref|
          metasploit_vuln_ref = metasploit_host_vuln.metasploit_refs.new
          metasploit_vuln_ref.ref = vuln_ref.content rescue nil
          metasploit_vuln_ref.save
        end
      end
    end

    events = @xml_doc.xpath('//event')

    events.each do |event|
      metasploit_event = metasploit_report.metasploit_events.new
      metasploit_event.event_id = event.search('id')[0].content rescue nil
      metasploit_event.workspace_id = event.search('workspace-id')[0].content rescue nil
      metasploit_event.host_id = event.search('host-id')[0].content rescue nil
      metasploit_event.metasploit_created_at = event.search('created-at')[0].content rescue nil
      metasploit_event.metasploit_updated_at = event.search('updated-at')[0].content rescue nil
      metasploit_event.name = event.search('name')[0].content rescue nil
      metasploit_event.critical = event.search('critical')[0].content rescue nil
      metasploit_event.seen = event.search('seen')[0].content rescue nil
      metasploit_event.username = event.search('username')[0].content rescue nil
      metasploit_event.info = event.search('info')[0].content rescue nil
      metasploit_event.module_rhost = event.search('module-rhost')[0].content rescue nil
      metasploit_event.module_name = event.search('module-name')[0].content rescue nil
      metasploit_event.save
    end

    services = @xml_doc.xpath('//service')

    services.each do |service|
      metasploit_service = metasploit_report.metasploit_services.new
      metasploit_service.service_id = service.search('id')[0].content rescue nil
      metasploit_service.host_id = service.search('host-id')[0].content rescue nil
      metasploit_service.metasploit_created_at = service.search('created-at')[0].content rescue nil
      metasploit_service.metasploit_updated_at = service.search('updated-at')[0].content rescue nil
      metasploit_service.port = service.search('port')[0].content rescue nil
      metasploit_service.proto = service.search('proto')[0].content rescue nil
      metasploit_service.state = service.search('state')[0].content rescue nil
      metasploit_service.name = service.search('name')[0].content rescue nil
      metasploit_service.info = service.search('info')[0].content rescue nil
      metasploit_service.save
    end

    modules = @xml_doc.xpath('//module_detail')

    modules.search('module_detail').each do |module_detail|
      metasploit_module_detail = metasploit_report.metasploit_module_details.new
      metasploit_module_detail.module_id = module_detail.search('id')[0].content rescue nil
      metasploit_module_detail.mtime = module_detail.search('mtime')[0].content rescue nil
      metasploit_module_detail.file = module_detail.search('file')[0].content rescue nil
      metasploit_module_detail.mtype = module_detail.search('mtype')[0].content rescue nil
      metasploit_module_detail.refname = module_detail.search('refname')[0].content rescue nil
      metasploit_module_detail.fullname = module_detail.search('fullname')[0].content rescue nil
      metasploit_module_detail.name = module_detail.search('name')[0].content rescue nil
      metasploit_module_detail.rank = module_detail.search('rank')[0].content rescue nil
      metasploit_module_detail.description = module_detail.search('description')[0].content rescue nil
      metasploit_module_detail.license = module_detail.search('license')[0].content rescue nil
      metasploit_module_detail.privileged = module_detail.search('privileged')[0].content rescue nil
      metasploit_module_detail.disclosure_date = module_detail.search('disclosure-date')[0].content rescue nil
      metasploit_module_detail.default_target = module_detail.search('default-target')[0].content rescue nil
      metasploit_module_detail.default_action = module_detail.search('default-action')[0].content rescue nil
      metasploit_module_detail.stance = module_detail.search('stance')[0].content rescue nil
      metasploit_module_detail.ready = module_detail.search('reday')[0].content rescue nil
      metasploit_module_detail.save

      module_detail.search('module_authors').each do |author|
        author_ids = []
        names = []
        emails = []
        author.search('id').each do |id|
          author_ids << id.content
        end
        author.search('name').each do |name|
          names << name.content
        end
        author.search('email').each do |email|
          emails << email.content
        end
        loop_counter = author_ids.length
        loop_counter.times do |lc|
          module_author = metasploit_module_detail.metasploit_module_authors.new
          module_author.author_id = author_ids[lc]
          module_author.name = names[lc]
          module_author.email = emails[lc]
          module_author.save
        end
      end

      module_detail.search('module_refs').each do |ref|
        ref_ids = []
        names = []
        ref.search('id').each do |id|
          ref_ids << id.content
        end
        ref.search('name').each do |name|
          names << name.content
        end
        loop_counter = ref_ids.length
        loop_counter.times do |lc|
          module_ref = metasploit_module_detail.metasploit_module_refs.new
          module_ref.module_ref_id = ref_ids[lc]
          module_ref.name = names[lc]
          module_ref.save
        end
      end

      module_detail.search('module_archs').each do |arch|
        arch_ids = []
        names = []
        arch.search('id').each do |id|
          arch_ids << id.content
        end
        arch.search('name').each do |name|
          names << name.content
        end
        loop_counter = arch_ids.length
        loop_counter.times do |lc|
          module_arch = metasploit_module_detail.metasploit_module_archs.new
          module_arch.module_archs_id = arch_ids[lc]
          module_arch.name = names[lc]
          module_arch.save
        end
      end

      module_detail.search('module_platforms').each do |platform|
        platform_ids = []
        names = []
        platform.search('id').each do |id|
          platform_ids << id.content
        end
        platform.search('name').each do |name|
          names << name.content
        end
        loop_counter = platform_ids.length
        loop_counter.times do |lc|
          module_platform = metasploit_module_detail.metasploit_module_platforms.new
          module_platform.module_platform_id = platform_ids[lc]
          module_platform.name = names[lc]
          module_platform.save
        end
      end

      module_detail.search('module_targets').each do |target|
        target_ids = []
        names = []
        metasploit_indexes = []
        target.search('id').each do |id|
          target_ids << id.content
        end
        target.search('index').each do |metasploit_index|
          metasploit_indexes << metasploit_index.content
        end
        target.search('name').each do |name|
          names << name.content
        end
        loop_counter = target_ids.length
        loop_counter.times do |lc|
          module_target = metasploit_module_detail.metasploit_module_targets.new
          module_target.module_target_id = target_ids[lc]
          module_target.metasploit_index = metasploit_indexes[lc]
          module_target.name = names[lc]
          module_target.save
        end
      end
    end

    credential_cores = @xml_doc.xpath('//cores')

    credential_cores.search('core').each do |credential_core|
      metasploit_credential_core = metasploit_report.metasploit_credential_cores.new
      metasploit_credential_core.core_id = credential_core.search('id')[0].content rescue nil
      metasploit_credential_core.origin_id = credential_core.search('origin-id')[0].content rescue nil
      metasploit_credential_core.origin_type = credential_core.search('origin-type')[0].content rescue nil
      metasploit_credential_core.private_id = credential_core.search('private-id')[0].content rescue nil
      metasploit_credential_core.public_id = credential_core.search('public-id')[0].content rescue nil
      metasploit_credential_core.realm_id = credential_core.search('realm-id')[0].content rescue nil
      metasploit_credential_core.workspace_id = credential_core.search('workspace-id')[0].content rescue nil
      metasploit_credential_core.metasploit_created_at = credential_core.search('created-at')[0].content rescue nil
      metasploit_credential_core.metasploit_updated_at = credential_core.search('updated-at')[0].content rescue nil
      metasploit_credential_core.logins_count = credential_core.search('logins-count')[0].content rescue nil
      metasploit_credential_core.save
    end

    origins = @xml_doc.xpath('//origins')

    origins.search('origin').each do |origin|
      metasploit_credential_origin = metasploit_report.metasploit_credential_origins.new
      metasploit_credential_origin.origin_id = origin.search('id')[0].content rescue nil
      metasploit_credential_origin.service_id = origin.search('service-id')[0].content rescue nil
      metasploit_credential_origin.module_full_name = origin.search('module-full-name')[0].content rescue nil
      metasploit_credential_origin.metasploit_created_at = origin.search('created-at')[0].content rescue nil
      metasploit_credential_origin.metasploit_updated_at = origin.search('updated-at')[0].content rescue nil
      metasploit_credential_origin.save
    end

    publics = @xml_doc.xpath('//publics')

    publics.search('public').each do |credential_public|
      metasploit_credential_public = metasploit_report.metasploit_credential_publics.new
      metasploit_credential_public.public_id = credential_public.search('id')[0].content rescue nil
      metasploit_credential_public.username = credential_public.search('username')[0].content rescue nil
      metasploit_credential_public.metasploit_created_at = credential_public.search('created-at')[0].content rescue nil
      metasploit_credential_public.metasploit_updated_at = credential_public.search('updated-at')[0].content rescue nil
      metasploit_credential_public.save
    end

    logins = @xml_doc.xpath('//logins')

    logins.search('login').each do |login|
      metasploit_credential_login = metasploit_report.metasploit_credential_logins.new
      metasploit_credential_login.login_id = login.search('id')[0].content rescue nil
      metasploit_credential_login.core_id = login.search('core-id')[0].content rescue nil
      metasploit_credential_login.service_id = login.search('service-id')[0].content rescue nil
      metasploit_credential_login.access_level = login.search('access-level')[0].content rescue nil
      metasploit_credential_login.status = login.search('status')[0].content rescue nil
      metasploit_credential_login.last_attempted_at = login.search('last-attempted-at')[0].content rescue nil
      metasploit_credential_login.metasploit_created_at = login.search('created-at')[0].content rescue nil
      metasploit_credential_login.metasploit_updated_at = login.search('updated-at')[0].content rescue nil
      metasploit_credential_login.save
    end

    privates = @xml_doc.xpath('//privates')

    privates.search('private').each do |credential_private|
      metasploit_credential_private = metasploit_report.metasploit_credential_privates.new
      metasploit_credential_private.private_id = credential_private.search('id')[0].content rescue nil
      metasploit_credential_private.metasploit_created_at = credential_private.search('created-at')[0].content rescue nil
      metasploit_credential_private.metasploit_updated_at = credential_private.search('updated-at')[0].content rescue nil
      metasploit_credential_private.private_type = credential_private.search('type')[0].content rescue nil
      metasploit_credential_private.data = credential_private.search('data')[0].content rescue nil
      metasploit_credential_private.jtr_format = credential_private.search('jtr-format')[0].content rescue nil
      metasploit_credential_private.save
    end

    em = PopulateEngagementMain.new(metasploit_report, user_id, engagement_id)
    em.populate

    metasploit_report.is_completed = true
    metasploit_report.save
  end
end