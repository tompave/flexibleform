namespace :db do
	desc "Fill database with sample data"
  task populate: :environment do
    make_visits
    make_submissions
    make_texts
  end

  task generate_texts: :environment do
    make_texts
  end
end

FORM_PAGE_BODY = "Testo di esempio:

<ol>
<li>Uno</li>
<li>Due</li>
<li> due e mezzo
<ul>
<li>Tre</li>
<li>Quattro</li>
</ul>
</li>
</ol>

<style>
ol > li > ul > li {
color: #0B7;
font-weight: bold;
}
</style>"
EULA_TEXT = 'Accetto i <a href="#eula">termini e condizioni</a>'
FORM_PAGE_BODY_2 = 'Qui qualche faq.<br><div id="eula">Qui va messo il testo dell\'<strong>eula</strong>...</div>'
THANKYOU_PAGE_BODY = "grazie grazie grazie grazie grazie"
FEEDBACK_PAGE_BODY = "Grazie per aver partecipato e per il tuo feedback"

FEEDBACK_ERROR_PAGE_BODY = "Sembra che tu stia provando a dare un feedback, ma l'url e' sbagliato"

MAIL_BODY = "Ciao [name] <br>

Questo e' il template email di default.<br>
Qui hai accesso a dei tag:<br>
<ul>
<li><strong>[name]</strong> e' il nome del destinatario,</li>
<li><strong>[email]</strong> e' l'indirizzo email a cui si sta inviando il messaggio,</li>
</ul>"


def make_visits
	30.times { |i| Visit.new.fill_properties.save }
	puts "Create #{Visit.count} visite.".colorize(:blue)
end

def make_submissions
	visits = Visit.all.shuffle
	prng = Random.new
	20.times do |i|
		visits.pop.create_submission(email: "#{random_mail(prng)}@mail.com",
															 location: "ivrea")
	end
	puts "Create #{Submission.count} submissions.".colorize(:blue)
end

def make_texts
	home_text = PageText.create(
		page: "home",
		title: UserConfig::APP_TITLE,
		heading: "Pagina di Iscrizione",
		body: FORM_PAGE_BODY,
		body2: FORM_PAGE_BODY_2,
		eula_text: EULA_TEXT )

	thankyou_text = PageText.create(
		page: "end",
		title: UserConfig::APP_TITLE,
		heading: "Grazie",
		body: THANKYOU_PAGE_BODY,
		body2: nil,
		eula_text: nil 
		)

	feedback_text = PageText.create(
		page: "land",
		title: UserConfig::APP_TITLE,
		heading: "Grazie",
		body: FEEDBACK_PAGE_BODY,
		body2: nil,
		eula_text: nil 
		)

	feedback_error_text = PageText.create(
		page: "fb_error",
		title: UserConfig::APP_TITLE,
		heading: "Errore",
		body: FEEDBACK_ERROR_PAGE_BODY,
		body2: nil,
		eula_text: nil 
		)

	puts "Creati i #{PageText.count} testi.".colorize(:blue)

	mail_template = EmailTemplate.new(
		subject: "#{UserConfig::APP_TITLE} Registration",
		style: "",
		body: MAIL_BODY,
		)
	mail_template.save
	puts "Creato il template email.\n ".colorize(:blue)
end


def random_number(prng)
	num = "3"
	9.times do |i|
		num << prng.rand(0..9).to_s
	end
	return num
end


def random_mail(prng)
	str = ""
	source = ('a'..'z').to_a.shuffle
	9.times do |i|
		str << source[prng.rand(0..25)]
	end
	return str
end
