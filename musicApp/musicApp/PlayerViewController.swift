//
//  PlayerViewController.swift
//  musicApp
//
//  Created by Никита Кисляков on 31.01.2024.
//

import AVFoundation
import UIKit

class PlayerViewController: ViewController {
    

    
    @IBOutlet var holder: UIView!
    
    public var position = 0
    var arrayOfSongs: [Song] = []
    var player: AVAudioPlayer?
    
    let playButton = UIButton()
    
    let pauseButton = UIButton()
    
    private let albumImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let artistNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let songNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    
 
    


    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.isHidden = true
        pauseButton.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    func configure() {
        // set up player
        let song = arrayOfSongs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else { return }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
                                   
            guard let player = player else { return }
            player.volume = 0.3
            player.play()
        }
        catch {
            print("error")
        }
        // set up UI elements
        
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: Int(holder.frame.size.width - 20),
                                      height: Int(holder.frame.size.width - 20))
        
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        // labels
        
        songNameLabel.frame = CGRect(x: 10,
                                     y: Int(albumImageView.frame.size.height + 10),
                                     width: Int(holder.frame.size.width - 20),
                                     height: Int(70))
        
        artistNameLabel.frame = CGRect(x: 10,
                                       y: Int(albumImageView.frame.size.height + 10) + 70,
                                       width: Int(holder.frame.size.width - 20),
                                       height: Int(70))
        
        albumNameLabel.frame = CGRect(x: 10,
                                      y: Int(albumImageView.frame.size.height + 10) + 70 + 70,
                                      width: Int(holder.frame.size.width - 20),
                                      height: Int(70))
        
        songNameLabel.text = song.name
        artistNameLabel.text = song.artistName
        albumNameLabel.text = song.albumName
        
        holder.addSubview(songNameLabel)
        holder.addSubview(artistNameLabel)
        holder.addSubview(albumNameLabel)
        
        // player controls
        
        let nextButton = UIButton()
        let prevButton = UIButton()
        
        // styling
        
        playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        pauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        prevButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        playButton.tintColor = .black
        pauseButton.tintColor = .black
        nextButton.tintColor = .black
        prevButton.tintColor = .black
        
        let yPosition =  artistNameLabel.frame.origin.y + 70 + 70 + 10
        let size: CGFloat = 60
        
        playButton.frame = CGRect(x: (holder.frame.size.width - size) / 2,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        pauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2,
                                   y: yPosition,
                                   width: size,
                                   height: size)
        
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        prevButton.frame = CGRect(x: 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        playButton.addTarget(self, action: #selector(didTapPlayPauseBtn), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(didTapPlayPauseBtn), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextBtn), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(didTapBackBtn), for: .touchUpInside)
        
        holder.addSubview(playButton)
        holder.addSubview(pauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(prevButton)
        
        // slider
        
        let slider = UISlider(frame: CGRect(x: 20,
                                            y: holder.frame.size.height - 60,
                                            width: holder.frame.size.width - 40,
                                            height: 50))
        slider.value = 0.3
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        holder.addSubview(slider)
       
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
    
    @objc func sliderValueChanged(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
        
    }
    
    @objc func didTapPlayPauseBtn() {
        if player?.isPlaying == true {
            player?.pause()
            playButton.isHidden = false
            pauseButton.isHidden = true
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30,
                                                   y: 30,
                                                   width: Int(self.holder.frame.size.width - 60),
                                                   height: Int(self.holder.frame.size.width - 60))
            })
        } else {
            player?.play()
            playButton.isHidden = true
            pauseButton.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10,
                                                   y: 10,
                                                   width: Int(self.holder.frame.size.width - 20),
                                                   height: Int(self.holder.frame.size.width - 20))
            })
        }
    }
    
    @objc func didTapBackBtn() {
        if position > 0 {
            position -= 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapNextBtn() {
        if position < songs.count - 1 {
            position += 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }

}
